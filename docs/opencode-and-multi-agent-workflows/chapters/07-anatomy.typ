#import "../../presentation-template/lib.typ": *

// 07-anatomy.typ -- field-by-field walk through a real persona
// shipped by this repo. Ported from mole/docs/subagents/02.

#section-slide("7", "Anatomy")

#content-slide("Where they live")[
  #bullets(
    [User-scoped (global): `~/.config/opencode/agents/<name>.md`],
    [Project-scoped: `<project>/.opencode/agents/<name>.md`],
    [Markdown body, YAML frontmatter at the top.],
    [opencode discovers them automatically; no registration step.],
    [Project scope wins over user scope, file-by-file, by name.],
  )
]

#code-slide("A real persona (the reviewer this repo ships)")[
```markdown
---
description: Use when a change, design, or piece of code needs
  an independent, adversarial correctness review --- invariants,
  hidden assumptions, semantic mistakes, architectural drift.
  Reads and critiques; does not edit. Trigger for "review",
  "audit", "sanity check", "before I merge".
mode: subagent
permission:
  edit: deny
  bash: ask
  webfetch: allow
  task: deny
---
```
  #note[
    The body below `---` is a normal Markdown system prompt:
    stance, what-you-do, what-you-don't, output format.
  ]
]

#content-slide("The frontmatter, field by field")[
  #bullets(
    [`description` --- the *router prompt*. The main agent reads
     this to decide whether to delegate. Include trigger
     phrases.],
    [`mode: subagent` --- this file is not a top-level agent
     (the user cannot invoke it directly as the primary).],
    [`permission.edit` --- `allow` / `ask` / `deny`. The Reviewer
     gets `deny` because it must not silently fix what it
     critiques.],
    [`permission.bash` --- same vocabulary. `ask` means the
     human gates every shell call.],
    [`permission.webfetch` --- read-only access to the open web.],
    [`permission.task` --- `deny` here stops the reviewer from
     dispatching its own sub-tasks; it does one thing.],
  )
  #note[
    The description is the single most important field. Routers
    don't read the body. If your description is vague, the
    persona is invisible.
  ]
]

#content-slide("The body is a system prompt")[
  #bullets(
    [No template required --- it's just Markdown.],
    [This repo's house structure: *Stance · What you do · How
     you work · What you do NOT do · Output format*.],
    [The "do NOT" list is load-bearing: it's what stops a
     reviewer from quietly rewriting your code.],
    [Output format pins the return shape so the calling agent
     can act on it without re-parsing prose.],
  )
]

#recap-slide(
  "Recap",
  (
    [Frontmatter wires routing and permissions.],
    [Body is a system prompt with a stance and a return shape.],
    [The "do NOT" list keeps the persona in its lane.],
  ),
  next: "What personas this repo actually ships.",
)
