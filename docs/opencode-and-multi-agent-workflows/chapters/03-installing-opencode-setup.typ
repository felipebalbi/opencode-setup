#import "../../presentation-template/lib.typ": *

// 03-installing-opencode-setup.typ -- clone the repo, run install,
// restart opencode.

#section-slide("3", "Installing opencode-setup")

#content-slide("What `opencode-setup` is")[
  #bullets(
    [A small repo that ships a generic baseline for opencode:
     eight subagent personas, a `opencode.jsonc` that pulls the
     superpowers plugin, an LSP toggle, and nothing else.],
    [Designed to live at `~/.config/opencode/` (the *global*
     scope), with per-project overrides in `<project>/.opencode/`.],
    [No machine-specific content. Your custom providers, your
     MCPs, your personal skill paths --- all in a local override
     file that the baseline never touches.],
  )
  #note[
    "Generic" is the load-bearing word. The baseline is what
    everyone on a team can share; the override is yours.
  ]
]

#code-slide("Clone and install (Linux / WSL / macOS)")[
```sh
git clone https://github.com/felipebalbi/opencode-setup.git \
    ~/workspace/opencode-setup
cd ~/workspace/opencode-setup

dst="$HOME/.config/opencode"
mkdir -p "$dst/agent"
for f in "$PWD/agent"/*.md; do
    ln -sf "$f" "$dst/agent/$(basename "$f")"
done

# Only if you don't already have a global opencode.jsonc.
ln -sf "$PWD/opencode.jsonc" "$dst/opencode.jsonc"
```
]

#code-slide("Clone and install (Windows, PowerShell)")[
```powershell
git clone https://github.com/felipebalbi/opencode-setup.git `
    D:\workspace\opencode-setup
Set-Location D:\workspace\opencode-setup

$dst = Join-Path $env:USERPROFILE ".config\opencode"
New-Item -ItemType Directory -Path (Join-Path $dst "agent") -Force | Out-Null
Get-ChildItem -LiteralPath (Join-Path $PWD "agent") -Filter *.md |
  ForEach-Object {
    New-Item -ItemType SymbolicLink -Force `
      -Path (Join-Path $dst "agent\$($_.Name)") -Target $_.FullName
  }
# Symlinks need Developer Mode or an elevated shell.
```
]

#content-slide("What just happened")[
  #bullets(
    [`~/.config/opencode/agent/*.md` are now symlinks back to
     the clone. `git pull` updates them in place.],
    [`~/.config/opencode/opencode.jsonc` is the baseline config
     (only if you didn't have one already).],
    [Existing global config? Install script left it alone ---
     you'll merge by hand, or load the baseline as an
     `OPENCODE_CONFIG` overlay (chapter 5).],
    [*Restart opencode.* The config is loaded at startup; a
     running session keeps the old one. On next launch, opencode
     also fetches the superpowers plugin into its package cache.],
  )
]
