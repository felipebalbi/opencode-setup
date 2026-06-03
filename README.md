# opencode-setup

Personal [opencode](https://opencode.ai) configuration:

- a generic baseline set of subagents (architect, coder, coordinator,
  docs, integrator, reliability, reviewer, tester) intended to live at
  `~/.config/opencode/agent/` and be overridden file-by-file by
  per-project `.opencode/agent/<name>.md` files;
- a generic baseline `opencode.jsonc` that pulls the
  [superpowers](https://github.com/obra/superpowers) plugin (and its
  bundled skills) and enables LSP integration.
- a Typst presentation template under `docs/presentation-template/`
  for slides about the agentic workflow itself --- two ef-themes
  palettes (`cyprus-light`, `bio-dark`), both green-forward.
- a ~45-minute training deck under
  `docs/opencode-and-multi-agent-workflows/` walking from "install
  opencode" through "author your own persona", built on the
  template above.

## Why this exists

I maintain a small specialist agent team across every project I work on.
The roles are the same everywhere; the project-specific knowledge isn't.
Without a global baseline, every project carries its own copy of the same
eight files and they drift.

This repo is the canonical source of truth for the baseline. Per-project
`.opencode/agent/` directories carry only the deltas that genuinely need
project context (a wire-protocol invariant, a CI matrix detail, a
peripheral-driver pattern).

## How superpowers gets pulled in

Superpowers is an opencode plugin, fetched directly from its GitHub repo.
The `opencode.jsonc` in this repo declares it:

```json
"plugin": [
    "superpowers@git+https://github.com/obra/superpowers.git"
]
```

When opencode starts, it fetches the plugin into
`~/.cache/opencode/packages/`, materialises the bundled skills, and
makes them available via the `skill` tool. That is the entire mechanism
— installing the `opencode.jsonc` from this repo is what gets you
superpowers. No extra step.

If you later want to pin or update the version, change the `plugin`
spec to e.g. `superpowers@git+https://github.com/obra/superpowers.git#v1.2.3`,
or use a different fork. opencode does not auto-update plugins
silently; updates happen when opencode restarts and re-resolves.

## Install (opencode, global scope)

opencode reads its global config from `~/.config/opencode/`
(`%USERPROFILE%\.config\opencode\` on Windows). Drop this repo's
`opencode.jsonc` and `agent/*.md` files there.

> **Heads-up about `opencode.jsonc`.** If you already have a global
> `opencode.jsonc` (or `opencode.json`) with machine-specific bits like
> a `provider`, `mcp`, or `model` block, **do not** symlink or copy
> this repo's `opencode.jsonc` over the top of it — opencode does not
> merge two top-level config files of the same name. The recommended
> patterns:
>
> 1. **Empty global scope:** install this repo's `opencode.jsonc` as
>    `~/.config/opencode/opencode.jsonc`. Done.
> 2. **You have machine-specific overrides:** install this repo's
>    `opencode.jsonc` as `~/.config/opencode/opencode.jsonc`, then put
>    your personal overrides in a separate file (e.g.
>    `~/.config/opencode/local.jsonc`) and point opencode at it via
>    `OPENCODE_CONFIG`. opencode deep-merges the env-var config on
>    top of the global one.
> 3. **You have an existing global config that already pulls
>    superpowers:** just install the `agent/*.md` files; skip the
>    `opencode.jsonc` step entirely. You already have what this repo
>    provides.

### Symlink (recommended)

Symlinks let `git pull` propagate updates instantly. On Windows, symlink
creation needs either Developer Mode enabled or an elevated shell.

Run these from the root of your clone of this repo (so `$PWD` resolves to
the `opencode-setup` directory). Substitute an absolute path for `$PWD`
if you prefer.

PowerShell:

```powershell
# Run from the root of your opencode-setup clone.
$dst = Join-Path $env:USERPROFILE ".config\opencode"
New-Item -ItemType Directory -Path (Join-Path $dst "agent") -Force | Out-Null

# Agents: symlink each baseline into ~/.config/opencode/agent/
Get-ChildItem -LiteralPath (Join-Path $PWD "agent") -Filter *.md | ForEach-Object {
    New-Item -ItemType SymbolicLink `
        -Path (Join-Path $dst "agent\$($_.Name)") `
        -Target $_.FullName -Force
}

# opencode.jsonc: symlink ONLY if no global config already exists.
$cfgDst = Join-Path $dst "opencode.jsonc"
$cfgAlt = Join-Path $dst "opencode.json"
if ((Test-Path $cfgDst) -or (Test-Path $cfgAlt)) {
    Write-Warning "Existing opencode config detected at $dst — leaving it alone."
    Write-Warning "Merge this repo's opencode.jsonc by hand, or load it via OPENCODE_CONFIG."
} else {
    New-Item -ItemType SymbolicLink -Path $cfgDst `
        -Target (Join-Path $PWD "opencode.jsonc") -Force
}
```

POSIX (bash/zsh):

```sh
# Run from the root of your opencode-setup clone.
dst="$HOME/.config/opencode"
mkdir -p "$dst/agent"

# Agents: symlink each baseline into ~/.config/opencode/agent/
for f in "$PWD/agent"/*.md; do
    ln -sf "$f" "$dst/agent/$(basename "$f")"
done

# opencode.jsonc: symlink ONLY if no global config already exists.
if [ -e "$dst/opencode.jsonc" ] || [ -e "$dst/opencode.json" ]; then
    echo "warn: existing opencode config detected at $dst — leaving it alone." >&2
    echo "warn: merge this repo's opencode.jsonc by hand, or load it via OPENCODE_CONFIG." >&2
else
    ln -sf "$PWD/opencode.jsonc" "$dst/opencode.jsonc"
fi
```

### Copy (fallback)

If you cannot create symlinks, copy instead — but re-run after every
`git pull`. Same conflict protection on `opencode.jsonc`.

```powershell
# Run from the root of your opencode-setup clone.
$dst = Join-Path $env:USERPROFILE ".config\opencode"
New-Item -ItemType Directory -Path (Join-Path $dst "agent") -Force | Out-Null
Copy-Item -LiteralPath (Join-Path $PWD "agent\*.md") `
    -Destination (Join-Path $dst "agent") -Force

$cfgDst = Join-Path $dst "opencode.jsonc"
$cfgAlt = Join-Path $dst "opencode.json"
if ((Test-Path $cfgDst) -or (Test-Path $cfgAlt)) {
    Write-Warning "Existing opencode config detected at $dst — leaving it alone."
} else {
    Copy-Item -LiteralPath (Join-Path $PWD "opencode.jsonc") `
        -Destination $cfgDst -Force
}
```

```sh
# Run from the root of your opencode-setup clone.
dst="$HOME/.config/opencode"
mkdir -p "$dst/agent"
cp -f "$PWD/agent/"*.md "$dst/agent/"

if [ -e "$dst/opencode.jsonc" ] || [ -e "$dst/opencode.json" ]; then
    echo "warn: existing opencode config detected at $dst — leaving it alone." >&2
else
    cp -f "$PWD/opencode.jsonc" "$dst/opencode.jsonc"
fi
```

### Restart opencode

opencode loads configuration at startup and does not hot-reload. Quit and
relaunch any running session. On first launch with the `superpowers`
plugin entry, opencode will fetch and cache the plugin into
`~/.cache/opencode/packages/` (network required). Subsequent launches
use the cache.

## Per-project overrides

opencode resolves agents by name. A project's `.opencode/agent/<name>.md`
fully replaces the global `~/.config/opencode/agent/<name>.md` of the same
name. There is no field-level merge — the project file is the entire
agent definition for that project.

Workflow for a project that needs to specialise an agent:

1. Start from this repo's baseline file as the seed.
2. Copy it to `<project>/.opencode/agent/<name>.md`.
3. Add the project-specific bits: trigger keywords in `description`, hard
   rules and tripwires under "How you work", project-specific examples,
   citations of `AGENTS.md` / `CONTRIBUTING.md` / CI scripts.
4. Commit it in the project repo. The override is now version-controlled
   alongside the project's own conventions.

If a per-project override drifts back toward the generic baseline (for
example, after a project-specific rule is retired), just delete the
override file. The global baseline takes over automatically.

## The agents

| Agent          | Mode     | Edits | Role                                                    |
| -------------- | -------- | ----- | ------------------------------------------------------- |
| `architect`    | subagent | no    | API and module-boundary design; produces specs, not code |
| `coder`        | subagent | yes   | Translates specifications into focused, scoped patches  |
| `coordinator`  | subagent | no    | Decomposes work, routes to specialists, tracks deps     |
| `docs`         | subagent | yes   | README, rustdoc, tutorials, architecture explainers     |
| `integrator`   | subagent | yes   | Stages, commits, drafts PRs; never force-pushes         |
| `reliability`  | subagent | no    | Failure-mode analysis; recovery and observability gaps  |
| `reviewer`     | subagent | no    | Adversarial correctness review; evidence-driven verdict |
| `tester`       | subagent | yes   | Edge-case discovery, repros, regression tests           |

All eight are `subagent` mode and intentionally narrow. They are meant to
be dispatched by a primary agent (or the coordinator), not driven
interactively as the top-level agent.

## What is NOT in this repo (yet)

- **Skills (personal).** My personal skills currently live at
  `~/.copilot/skills/` on my machine, and need a review pass before
  being absorbed into this repo. Until then, register that path in
  your own local override (see "Machine-specific config" below) — the
  baseline shipped here does not bake in any personal skill path.
  Superpowers' bundled skills are pulled in automatically via the
  plugin; separate concern.
- **Custom commands.** I have a few `~/.config/opencode/commands/*.md`
  slash-commands that wrap specific skills (e.g.
  `org-roam-daily`). They depend on the underlying skill being
  installed; they will land here in the same pass that lands the
  skills.
- **Plugin / marketplace manifests for other tools.** opencode-only
  for now. Adding Agency Copilot or Claude Code support later means
  wrapping `agent/` (and eventually `skill/`) in a `plugin.json` and
  optionally a `marketplace.json`.
- **Machine-specific config.** No `provider` overrides, no `mcp`
  servers, no `model` default, no `skills.paths`. Put those in your
  own `~/.config/opencode/local.jsonc` and point `OPENCODE_CONFIG` at
  it. Example:
  ```json
  // ~/.config/opencode/local.jsonc
  {
      "$schema": "https://opencode.ai/config.json",
      "skills": { "paths": ["~/.copilot/skills"] },
      "model": "my-internal-model"
  }
  ```

## License

See [LICENSE](LICENSE).
