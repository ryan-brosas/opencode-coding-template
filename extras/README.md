# Optional OpenCode Packs

The default `.opencode/` tree is intentionally focused on coding. These packs contain useful but non-core assets. They are not loaded by OpenCode unless you copy them into `.opencode/`.

## Install a Pack

```bash
PACK=ui-pack
cp -r extras/$PACK/agent/* .opencode/agent/ 2>/dev/null || true
cp -r extras/$PACK/command/* .opencode/command/ 2>/dev/null || true
cp -r extras/$PACK/skill/* .opencode/skill/ 2>/dev/null || true
cp -r extras/$PACK/plugin/* .opencode/plugin/ 2>/dev/null || true
```

Review files before installing. Some packs may require optional API keys from `env.integrations.example`.

## Packs

- `ui-pack` — design, visual, Figma, browser, React/UI helpers
- `cloud-pack` — Cloudflare, Supabase, Resend, Polar, Vercel helpers
- `research-pack` — deep research, context engineering, Webclaw, prompt leverage
- `product-pack` — PRD, brainstorming, init/explore/health commands
- `org-pack` — GitHub/Jira workflow helpers
- `language-pack` — Swift/Core Data specialists
- `autonomous-pack` — LFG/compound/swarm workflows
- `integration-pack` — optional local plugins and DCP/opencodex config
