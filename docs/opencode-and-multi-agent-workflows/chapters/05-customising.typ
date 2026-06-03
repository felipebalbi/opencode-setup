#import "../../presentation-template/lib.typ": *

// 05-customising.typ -- local.jsonc + OPENCODE_CONFIG, plus
// per-project agent overrides.

#section-slide("5", "Customising without forking")

#content-slide("Two places to extend")[
  #numbered(
    [*Your machine, your taste.* Custom providers, custom MCPs,
     extra skill paths, default model --- all in a personal
     overlay file that opencode merges on top of the baseline.],
    [*Per-project, when it matters.* A
     `<project>/.opencode/agents/<name>.md` file fully replaces
     the global agent of the same name --- no merge, just
     replacement.],
  )
  #note[
    Two scopes, two override mechanisms. The first deep-merges
    JSON; the second swaps a whole agent definition by name.
  ]
]

#code-slide("Overlay: ~/.config/opencode/local.jsonc")[
```json
{
    "$schema": "https://opencode.ai/config.json",
    "model": "github-copilot/your-preferred-model",
    "skills": { "paths": ["~/path/to/your/extra/skills"] },
    "mcp": {
        "my-mcp": {
            "type": "local",
            "command": ["your-mcp-binary", "subcommand"],
            "enabled": true
        }
    }
}
```
  #note[
    Add `provider` blocks here too if you need custom model
    metadata; structure mirrors the `mcp` block above.
  ]
]

#code-slide("Wire the overlay in")[
```sh
# Make opencode load the overlay on every start.
export OPENCODE_CONFIG="$HOME/.config/opencode/local.jsonc"
```

opencode deep-merges this file on top of the global
`opencode.jsonc`. The baseline keeps shipping superpowers and the
agents; your overlay adds the bits that are *yours*.

The overlay file is NOT in the `opencode-setup` repo. Anything in
it stays on your machine.
]

#content-slide("Per-project agent overrides")[
  #bullets(
    [Drop a `<project>/.opencode/agents/architect.md` (for example)
     in any repo you work on.],
    [That file *replaces* the global `architect` agent while
     you're working in that project. There is no field-level
     merge; the project file is the entire definition.],
    [Use this when a project has rules the generic baseline can't
     reasonably know about: wire-protocol invariants, lint
     policies, in-tree conventions.],
    [Delete the override later and the global baseline takes
     over again --- no migration needed.],
  )
]

#recap-slide(
  "Recap",
  (
    [Personal overlay via `local.jsonc` + `OPENCODE_CONFIG`.],
    [Per-project agent overrides via
     `<project>/.opencode/agents/<name>.md`.],
    [The baseline is shared; the deltas are yours.],
  ),
  next: "Why the eight personas are not just longer prompts.",
)
