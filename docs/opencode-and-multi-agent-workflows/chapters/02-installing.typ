#import "../../presentation-template/lib.typ": *

// 02-installing.typ -- platform-specific install + first-run auth.

#section-slide("2", "Installing opencode")

#code-slide("Linux: one-line installer (official)")[
```sh
curl -fsSL https://opencode.ai/install | bash
```

The script drops the `opencode` binary onto your `PATH` and prints
where. Works on every mainstream distribution.

Distro-specific alternatives also exist: `pacman -S opencode` on
Arch, `brew install anomalyco/tap/opencode` via Homebrew on Linux,
or `npm install -g opencode-ai` if you already live in Node.
]

#code-slide("Windows: winget (terminal version)")[
```powershell
winget install SST.opencode
```

That's the *terminal* (TUI) build --- the one this deck is about.
There is also `SST.OpenCodeDesktop`; don't install that one unless
you specifically want the desktop GUI.
]

#content-slide("A note on Windows install paths")[
  #callout(kind: "info", icon: "ℹ")[
    The official opencode docs recommend WSL on Windows and list
    Chocolatey, Scoop, NPM, Mise, Docker as supported package
    managers. `winget` works fine but is community-maintained,
    not first-party.
  ]
  #v(0.8em)
  #bullets(
    [If you already use Chocolatey: `choco install opencode`.],
    [If you already use Scoop: `scoop install opencode`.],
    [Pure-Node setups can do `npm install -g opencode-ai` on any
     OS.],
    [WSL gets you the Linux story end-to-end --- the safest
     bet if anything feels off in native Windows.],
  )
]

#code-slide("First-run authentication")[
```text
$ opencode               # launch the TUI
> /connect               # opens the provider picker
```

Pick a provider (OpenCode Zen is the curated default; you can
also point at Anthropic, OpenAI, GitHub Copilot, etc.). Paste
the API key when prompted; opencode stores it locally and reuses
it forever.

For paid GitHub Copilot, the auth flow is OAuth-style --- pick
"GitHub Copilot" and follow the device-code prompt.
]

#recap-slide(
  "Recap",
  (
    [Linux: `curl … | bash`. Distro package if you prefer.],
    [Windows: `winget install SST.opencode` for the TUI build.],
    [First run: `/connect` in the TUI, pick provider, paste key
     (or OAuth).],
  ),
  next: "Installing opencode-setup on top.",
)
