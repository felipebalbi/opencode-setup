#import "../../presentation-template/lib.typ": *

// 01-why-opencode.typ -- what opencode is, why use a coding agent,
// and (the real question for this audience) why pick opencode over
// the other terminal-based coding agents you already know about
// --- chiefly Agency Copilot.

#section-slide("1", "Why opencode")

#content-slide("What opencode is")[
  #bullets(
    [An open-source AI coding agent (`github.com/anomalyco/opencode`)
     that runs in your terminal --- TUI by default, with desktop
     and IDE variants for the people who want them.],
    [Speaks to any LLM provider you have credentials for ---
     Anthropic, OpenAI, GitHub Copilot, OpenCode Zen, your own
     gateway. Bring your own keys.],
    [Operates on your repo with the tools your shell already
     has: read, edit, grep, glob, bash, the language server,
     plus an MCP layer for everything else.],
    [Configurable end-to-end through plain text files ---
     `opencode.jsonc`, agents as Markdown, skills as Markdown,
     plugins as `git+` URLs --- all check-in-able.],
  )
  #note[
    Lead with what it is, then the next slide is the real
    question: why this one over the obvious alternative.
  ]
]

#content-slide("Compared to what?")[
  #bullets(
    [Today's realistic comparison isn't raw chat. It's
     *Agency Copilot* --- also terminal-based, also coding-agent
     shaped, also speaks MCP, also ships personas and skills.],
    [The two converge on the same architecture: a TUI driving
     an LLM with shell-shaped tools and an MCP plane for
     everything else.],
    [So the choice isn't "terminal vs no terminal" or
     "agent vs no agent". The choice is *which terminal coding
     agent fits your hands*.],
  )
  #note[
    Set up the comparison honestly. Both are good tools. The
    next slide is where I stake my preference and say why.
  ]
]

#compare-slide(
  "Agency Copilot and opencode, side by side",
  "Agency Copilot",
  bullets(
    [Microsoft-managed; opinionated defaults.],
    [Mature plugin marketplace and install flow.],
    [Skills, agents, MCPs live in a plugin dir
     with a `plugin.json` manifest.],
    [Auth and providers wired for you.],
  ),
  "opencode",
  bullets(
    [Open source, no opinions you can't override.],
    [One `opencode.jsonc`; `OPENCODE_CONFIG`
     overlays deep-merge on top.],
    [Agents and skills are plain Markdown ---
     no manifest required.],
    [Per-project `.opencode/agents/<name>.md`
     overrides the global by name.],
  ),
  verdict: [Both work. I find opencode more *comfortable*.],
)

#recap-slide(
  "Recap",
  (
    [opencode = open-source terminal coding agent with a
     plain-file config story.],
    [Comparison point isn't raw chat --- it's other terminal
     coding agents, primarily Agency Copilot.],
    [Pick on ergonomics: how much friction sits between
     "I want to change a behaviour" and "the change took
     effect".],
  ),
  next: "Installing opencode.",
)
