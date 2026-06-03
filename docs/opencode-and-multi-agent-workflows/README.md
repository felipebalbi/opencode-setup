# opencode and Multi-agent Workflows --- slide deck

A Typst training deck on opencode and the multi-agent workflow
this repo ships: install opencode, install `opencode-setup`, see
what you got, then learn how the subagent personas work and how
to author your own.

Targets a ~45-minute training slot for engineers who have heard
of opencode but never installed it.

Built on the shared `docs/presentation-template/` design system
(see that directory's `README.md` for theme switching, slide
kinds, and authoring guidance).

## Build

Requirements: same as `docs/presentation-template/`. From this
directory:

```sh
make             # builds slides.pdf (cyprus-light)
make notes       # builds slides-notes.pdf with speaker notes
make dark        # builds slides-dark.pdf (bio-dark)
make all         # all three
make watch       # auto-rebuild slides.pdf while editing
make clean       # remove built PDFs
```

Or invoke Typst directly:

```sh
typst compile --root .. slides.typ
typst compile --root .. --input notes=true slides.typ
typst compile --root .. --input theme=dark slides.typ
```

Built PDFs are gitignored.

## Layout

```text
slides.typ              entry point: page setup, fonts, chapter
                        include list.
chapters/               one .typ file per part.
  00-cover.typ          cover + opening promise.
  01-why-opencode.typ   what opencode is, why use a coding agent.
  02-installing.typ     winget (Windows), curl|bash (Linux), auth.
  03-installing-opencode-setup.typ  clone, install, restart.
  04-what-you-got.typ   the 8 agents, superpowers, baseline jsonc.
  05-customising.typ    local.jsonc, OPENCODE_CONFIG, per-project.
  06-why-personas.typ   four properties that earn their keep.
  07-anatomy.typ        frontmatter + body, field by field.
  08-the-eight.typ      this repo's eight, in compare-pairs.
  09-invocation.typ     explicit / auto-routing / fleet.
  10-authoring.typ      rules of thumb + house structure.
  11-cost-discipline.typ  cheap by default, named escalation.
  12-anti-patterns.typ  four ways to ruin a persona.
  13-recap.typ          starter persona, recap, thank-you.
Makefile                build wrapper.
```

## Provenance

Chapters 6 through 12 are ports of the equivalent chapters from
[mole/docs/subagents/][mole-subagents] (MIT, same author).
Structure preserved; mole-specific references replaced with
opencode-setup equivalents or generic phrasing.

[mole-subagents]: https://github.com/felipebalbi/mole/tree/main/docs/subagents

## Source material

The deck grounds the agent examples in the real files under
`agents/` at the root of this repo. If you edit a persona, the
corresponding slide in `chapters/07-anatomy.typ` or
`chapters/08-the-eight.typ` may drift.
