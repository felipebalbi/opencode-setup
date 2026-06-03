#import "../../presentation-template/lib.typ": *

// 04-what-you-got.typ -- name the eight agents, the plugin, the
// baseline config; introduce the override model briefly.

#section-slide("4", "What you got")

#content-slide("Three things landed in your global scope")[
  #numbered(
    [*Eight subagent personas* under `~/.config/opencode/agents/`
     --- architect, coder, coordinator, docs, integrator,
     reliability, reviewer, tester.],
    [*A baseline `opencode.jsonc`* that turns on LSP integration
     and pulls the [superpowers](https://github.com/obra/superpowers)
     plugin via its git URL.],
    [*No machine-specific bits.* No providers, no MCPs, no model
     defaults, no personal skill paths. Those go in a local
     override file (see chapter 5).],
  )
]

#content-slide("The eight, at a glance")[
  #three-col(
    bullets(
      [*architect* --- design],
      [*coder* --- implementation],
      [*reviewer* --- critique],
    ),
    bullets(
      [*tester* --- adversarial QA],
      [*reliability* --- failure modes],
      [*docs* --- explanation],
    ),
    bullets(
      [*integrator* --- ship it],
      [*coordinator* --- orchestration],
    ),
  )
  #note[
    Eight personas, each single-purpose. We'll dig into the
    pairwise contrasts in chapter 8 once we've covered the
    anatomy.
  ]
]

#content-slide("Superpowers, in one paragraph")[
  #bullets(
    [An opencode plugin that ships a set of process-discipline
     skills: brainstorming, writing-plans, executing-plans,
     systematic-debugging, test-driven-development,
     verification-before-completion, and others.],
    [Loaded automatically once your `opencode.jsonc` lists it in
     the `plugin` array; opencode fetches it from GitHub on first
     start and caches it under `~/.cache/opencode/packages/`.],
    [Skills are surfaced to the model via the `skill` tool ---
     they're discoverable by description and invoked on demand,
     not always-on prompt bloat.],
  )
  #note[
    The skills compose with personas: a persona is *who*, a
    skill is *how*. The reviewer persona can invoke the
    verification-before-completion skill.
  ]
]
