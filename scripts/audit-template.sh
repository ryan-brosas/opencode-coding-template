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

check "root opencode.json exists" test -f opencode.json
check "root tui.json exists" test -f tui.json
check "no nested active opencode config" test ! -f .opencode/opencode.json
check "no nested active tui config" test ! -f .opencode/tui.json
check "no nested env example" test ! -f .opencode/.env.example
check "opencode.json parses" bash -c 'python3 -m json.tool opencode.json >/dev/null'
check "tui.json parses" bash -c 'python3 -m json.tool tui.json >/dev/null'

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

check "no ghost /start references in active workflow docs" bash -c 'paths=(.opencode/README.md .opencode/agent .opencode/command); while IFS= read -r f; do paths+=("$f"); done < <(find .opencode/skill -mindepth 2 -maxdepth 2 -name SKILL.md); ! rg -n "/start|start <" "${paths[@]}" >/dev/null'

check "generated plan artifacts not tracked" bash -c '! git ls-files ".opencode/plans/*.md" | grep -v "README.md" | grep -q .'

check "focused default counts" bash -c '[ "$(find .opencode/agent -maxdepth 1 -name "*.md" | wc -l | tr -d " ")" = 7 ] && [ "$(find .opencode/command -maxdepth 1 -name "*.md" | wc -l | tr -d " ")" = 11 ] && [ "$(find .opencode/plugin -maxdepth 1 -name "*.ts" | wc -l | tr -d " ")" = 3 ]'

check "optional packs exist" bash -c '[ -d extras/ui-pack ] && [ -d extras/cloud-pack ] && [ -d extras/research-pack ] && [ -d extras/product-pack ] && [ -d extras/autonomous-pack ]'

check "optional power workflows are not active by default" bash -c '[ ! -f .opencode/agent/painter.md ] && [ ! -f .opencode/command/lfg.md ] && [ ! -f .opencode/command/compound.md ] && [ ! -f .opencode/plugin/copilot-auth.ts ] && [ ! -f .opencode/plugin/prompt-leverage.ts ] && [ ! -f .opencode/plugin/rtk.ts ]'

check "no duplicated active files in extras" python3 - <<'PY'
from pathlib import Path
import sys
checks = [
    (Path('.opencode/agent'), 'agent', '*.md'),
    (Path('.opencode/command'), 'command', '*.md'),
    (Path('.opencode/plugin'), 'plugin', '*.ts'),
]
dupes=[]
for active_dir, subdir, pattern in checks:
    active_names = {p.name for p in active_dir.glob(pattern)}
    for extra_dir in Path('extras').glob(f'*/{subdir}'):
        for p in extra_dir.glob(pattern):
            if p.name in active_names:
                dupes.append(f'{p.name}: {active_dir} and {extra_dir}')
active_skills = {p.name for p in Path('.opencode/skill').iterdir() if p.is_dir()}
for extra_skill_dir in Path('extras').glob('*/skill'):
    for p in extra_skill_dir.iterdir():
        if p.is_dir() and p.name in active_skills:
            dupes.append(f'{p.name}: .opencode/skill and {extra_skill_dir}')
if dupes:
    print('\n'.join(dupes), file=sys.stderr)
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

printf '\nInventory:\n'
printf '  agents:   %s\n' "$(find .opencode/agent -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')"
printf '  commands: %s\n' "$(find .opencode/command -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')"
printf '  skills:   %s\n' "$(find .opencode/skill -mindepth 2 -maxdepth 2 -name 'SKILL.md' | wc -l | tr -d ' ')"
printf '  tools:    %s\n' "$(find .opencode/tool -maxdepth 1 -name '*.ts' | wc -l | tr -d ' ')"
printf '  plugins:  %s\n' "$(find .opencode/plugin -maxdepth 1 -name '*.ts' | wc -l | tr -d ' ')"

exit "$fail"
