#!/usr/bin/env bash
set -euo pipefail

fail=0
check() {
	local name="$1"
	shift
	if "$@"; then
		printf '✓ %s\n' "$name"
	else
		printf '✗ %s\n' "$name" >&2
		fail=1
	fi
}

check "audit script is multiline shell" bash -c 'test "$(wc -l < scripts/audit-template.sh)" -gt 100 && test "$(sed -n "1p" scripts/audit-template.sh)" = "#!/usr/bin/env bash" && test "$(sed -n "2p" scripts/audit-template.sh)" = "set -euo pipefail"'
check "root opencode.json exists" test -f opencode.json
check "root tui.json exists" test -f tui.json
check "no nested active opencode config" test ! -f .opencode/opencode.json
check "no nested active tui config" test ! -f .opencode/tui.json
check "no nested env example" test ! -f .opencode/.env.example
check "opencode.json parses" bash -c 'python3 -m json.tool opencode.json >/dev/null'
check "tui.json parses" bash -c 'python3 -m json.tool tui.json >/dev/null'
check "root JSON is pretty-printed" python3 - <<'PY'
from pathlib import Path
import json, sys
bad=[]
for name in ('opencode.json', 'tui.json'):
    path = Path(name)
    data = json.loads(path.read_text())
    expected = json.dumps(data, indent=4, ensure_ascii=True) + '\n'
    actual = path.read_text()
    if actual != expected:
        bad.append(name)
if bad:
    print('not python -m json.tool formatted: ' + ', '.join(bad), file=sys.stderr)
    sys.exit(1)
PY

check "no broad bash allow" bash -c '! python3 - <<"PY"
import json
cfg=json.load(open("opencode.json"))
raise SystemExit(0 if cfg.get("permission",{}).get("bash",{}).get("*") == "allow" else 1)
PY'

check "npm/npx are ask by default" python3 - <<'PY'
import json, sys
bash=json.load(open('opencode.json')).get('permission',{}).get('bash',{})
sys.exit(0 if bash.get('npm *') == 'ask' and bash.get('npx *') == 'ask' else 1)
PY

check "agent bash permissions avoid wildcard allow" python3 - <<'PY'
from pathlib import Path
import sys
bad=[]
for path in Path('.opencode/agent').glob('*.md'):
    in_bash=False
    for line in path.read_text().splitlines():
        if line == '  bash:':
            in_bash=True
            continue
        if in_bash and line.startswith('  ') and not line.startswith('    '):
            in_bash=False
        if in_bash and line.strip() in {'"*": allow', "'*': allow"}:
            bad.append(str(path))
if bad:
    print('\n'.join(bad), file=sys.stderr)
    sys.exit(1)
PY

check "no @latest NPM plugins enabled" bash -c '! python3 - <<"PY"
import json, sys
plugins=json.load(open("opencode.json")).get("plugin", []) or []
sys.exit(0 if any("@latest" in p for p in plugins) else 1)
PY'

check "optional MCPs disabled" python3 - <<'PY'
import json, sys
mcp=json.load(open('opencode.json')).get('mcp', {})
optional=('tilth','webclaw','figma-mcp-go')
sys.exit(0 if all(not mcp.get(k,{}).get('enabled', False) for k in optional if k in mcp) else 1)
PY

check "AGENTS.md is loaded by root config" python3 - <<'PY'
import json, sys
instructions=json.load(open('opencode.json')).get('instructions', [])
sys.exit(0 if '.opencode/AGENTS.md' in instructions else 1)
PY

check "no ghost /start references in active workflow docs" bash -c 'paths=(.opencode/README.md .opencode/agent .opencode/command); while IFS= read -r f; do paths+=("$f"); done < <(find .opencode/skill -mindepth 2 -maxdepth 2 -name SKILL.md); ! rg -n "/start|start <" "${paths[@]}" >/dev/null'

check "generated plan artifacts not tracked" bash -c '! git ls-files ".opencode/plans/*.md" | grep -v "README.md" | grep -q .'

check "focused inventory exact" python3 - <<'PY'
from pathlib import Path
import sys
expected = {
    Path('.opencode/agent'): {'build.md', 'explore.md', 'general.md', 'painter.md', 'plan.md', 'review.md', 'scout.md', 'vision.md'},
    Path('.opencode/command'): {'create.md', 'design.md', 'handoff.md', 'health.md', 'iterate.md', 'lfg.md', 'plan.md', 'pr.md', 'research.md', 'resume.md', 'review-codebase.md', 'ship.md', 'status.md', 'ui-review.md', 'ui-slop-check.md', 'verify.md'},
    Path('.opencode/plugin'): {'prompt-leverage.ts', 'rtk.ts', 'sessions.ts', 'skill-mcp.ts'},
}
errors=[]
for directory, names in expected.items():
    pattern = '*.ts' if directory.name == 'plugin' else '*.md'
    actual = {p.name for p in directory.glob(pattern)}
    if actual != names:
        errors.append(f'{directory}: expected {sorted(names)}, got {sorted(actual)}')
if errors:
    print('\n'.join(errors), file=sys.stderr)
    sys.exit(1)
PY

check "active skill calls resolve" python3 - <<'PY'
from pathlib import Path
import re, sys
missing=[]
for root in [Path('.opencode/agent'), Path('.opencode/command')]:
    for path in root.glob('*.md'):
        for name in re.findall(r'skill\(\{ name: "([^"]+)"', path.read_text()):
            if not (Path('.opencode/skill') / name).is_dir():
                missing.append(f'{path}: {name}')
if missing:
    print('\n'.join(missing), file=sys.stderr)
    sys.exit(1)
PY

check "runtime markdown frontmatter is multiline and parseable" python3 - <<'PY'
from pathlib import Path
import sys

required = set()
required.update(Path('.opencode/agent').glob('*.md'))
required.update(Path('.opencode/command').glob('*.md'))
required.update(Path('.opencode/skill').glob('*/SKILL.md'))
required.update(Path('extras').glob('*/agent/*.md'))
required.update(Path('extras').glob('*/command/*.md'))
required.update(Path('extras').glob('*/skill/*/SKILL.md'))

files = set(required)
files.update(Path('extras').glob('**/*.md'))

bad=[]
for path in sorted(files):
    lines=path.read_text(errors='ignore').splitlines()
    must_have_frontmatter = path in required
    if not lines:
        if must_have_frontmatter:
            bad.append(f'{path}: empty file')
        continue
    if lines[0].strip() != '---':
        if must_have_frontmatter or lines[0].lstrip().startswith('---'):
            bad.append(f'{path}: frontmatter must start with standalone ---')
        continue
    try:
        close=next(i for i, line in enumerate(lines[1:], 1) if line.strip() == '---')
    except StopIteration:
        bad.append(f'{path}: missing closing ---')
        continue
    if close == 1:
        bad.append(f'{path}: empty frontmatter')
    frontmatter='\n'.join(lines[1:close])
    if path.name == 'SKILL.md' and '/skill/' in path.as_posix():
        if 'name:' not in frontmatter or 'description:' not in frontmatter:
            bad.append(f'{path}: skill frontmatter missing name/description')
if bad:
    print('\n'.join(bad), file=sys.stderr)
    sys.exit(1)
PY

printf '\nInventory:\n'
printf '  agents:   %s\n' "$(find .opencode/agent -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')"
printf '  commands: %s\n' "$(find .opencode/command -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')"
printf '  skills:   %s\n' "$(find .opencode/skill -mindepth 2 -maxdepth 2 -name 'SKILL.md' | wc -l | tr -d ' ')"
printf '  tools:    %s\n' "$(find .opencode/tool -maxdepth 1 -name '*.ts' | wc -l | tr -d ' ')"
printf '  plugins:  %s\n' "$(find .opencode/plugin -maxdepth 1 -name '*.ts' | wc -l | tr -d ' ')"

exit "$fail"
