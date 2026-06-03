# opencode-setup presentation template

A reusable Typst design system for `opencode-setup` documentation
decks --- conference talks, internal walk-throughs of the agentic
workflow, lightning slides about a specific subagent, anything you
want to project on a wall while talking about how the agent team is
wired together. Lifted from the `mole` project's
`presentation-template/` and re-themed in green for the
opencode-setup identity.

## What you get

- A polylux-based deck skeleton, 16:9 paper, relative-grid layout
  throughout (no hardcoded paddings or pixel positioning).
- Two themes from Protesilaos Stavrou's
  [ef-themes](https://github.com/protesilaos/ef-themes), both
  green-forward by design:
  - `cyprus-light` --- warm cream paper, cypress-green ink, deep
    forest-green accent. The opencode-setup house style.
  - `bio-dark` --- warm near-black paper, cool sage-green ink,
    bright sea-green accent. Same hue family, inverted lightness.
- A vocabulary of slide kinds covering the common shapes (cover,
  section divider, content, code, compare, definition, stat,
  quote, try-it, provocation, recap, thank-you).
- A built-in speaker-notes mode toggled with a single CLI flag.
- A `starter/` directory with a minimal copy-paste skeleton.

The template intentionally has **no opencode-setup-specific
content** --- nothing in `lib.typ` or `theme.typ` references any
particular subagent, skill, or workflow. It is suitable for any
deck that wants the opencode-setup look.

## Quick start

From the repo root:

```sh
cp -r docs/presentation-template/starter docs/my-new-deck
cd docs/my-new-deck
make             # builds slides.pdf
```

Then edit `chapters/00-cover.typ` and add more chapters as needed.

## Requirements

- [Typst](https://typst.app) 0.14.2 or newer.
- Polylux 0.4.0 (resolved automatically from the typst package
  cache; pinned in `lib.typ`).
- The [Aporetic](https://github.com/SaschaSommer/aporetic) font
  family installed on the OS font path (`Aporetic Sans`,
  `Aporetic Serif`, `Aporetic Sans Mono`). Without it typst falls
  back to its bundled default and emits one warning per family.
- GNU `make` for the convenience wrapper (optional --- you can
  invoke `typst compile` directly).

## Importing from a consumer deck

A deck under `docs/<name>/` imports the template with a relative
path:

```typst
#import "../presentation-template/lib.typ": *

#set page(
  paper: "presentation-16-9",
  margin: (x: 6%, y: 5%),
  fill: bg-page,
)

#set text(font: font-sans, size: 18pt, fill: ink)

#cover-slide(
  "My deck",
  "A short subtitle",
  "Author",
  "2026-06-03",
)
```

## Theme switching

Themes are selected at compile time:

```sh
typst compile slides.typ                       # cyprus-light (default)
typst compile --input theme=dark slides.typ    # bio-dark
```

Any unrecognised name falls back to `cyprus-light`, so a typo
renders a legible deck rather than crashing.

To add a third theme, add a dictionary in `theme.typ` with the same
keys as the existing two and extend the `theme-name` switch. No
changes to `lib.typ` are needed.

## Speaker notes

Wrap any prose in `#note[...]` and it stays invisible in the default
build. Pass `--input notes=true` (or run `make notes`) and the same
content renders as a faint italic block at the bottom of each
slide --- useful for self-study and for rehearsing a live talk.

```typst
#content-slide(title: "A point")[
  #bullets(
    [The visible bullet],
    [Another visible bullet],
  )
  #note[
    Reminder for the speaker: this is where the demo lives.
  ]
]
```

`notes=true` and `theme=dark` compose:

```sh
typst compile --input notes=true --input theme=dark slides.typ
```

## Slide kinds

All slide kinds are documented inline in `lib.typ`. The vocabulary:

| Kind                 | Purpose                                            |
| -------------------- | -------------------------------------------------- |
| `cover-slide`        | Title slide. Inverted chrome, accent stripe.       |
| `section-slide`      | Part divider. Updates the chrome footer label.     |
| `content-slide`      | The everyday slide. Title + body.                  |
| `code-slide`         | Titled slide whose body is one or more raw blocks. |
| `definition-slide`   | One big term + optional etymology + body.          |
| `stat-slide`         | One big number + caption.                          |
| `quote-slide`        | Big italic pull-quote.                             |
| `compare-slide`      | Two columns + optional verdict.                    |
| `try-it-slide`       | Prompt + hint + "answer on the next slide".        |
| `provocation-slide`  | Rhetorical prompt with no follow-up.               |
| `recap-slide`        | Checkmarked summary + optional "next up" pointer.  |
| `thank-you-slide`    | Inverted-chrome close + repo / manual pointers.    |

Plus atoms (`kicker`, `rule`, `pill`, `tag`, `callout`, `bullets`,
`numbered`, `checks`, `stat-block`, `two-col`, `three-col`,
`code-panel`).

## File layout

```text
presentation-template/
├── README.md         this file
├── theme.typ         color tokens; exports cyprus-light + bio-dark
├── lib.typ           slide kinds, atoms, notes-mode, chrome footer
└── starter/          copy-paste skeleton for a new deck
    ├── slides.typ
    ├── Makefile
    └── chapters/
        └── 00-cover.typ
```

## Design rules (for anyone editing the template itself)

- **Never hardcode an `rgb(...)` in `lib.typ`.** All colors come
  from `theme.active`. Adding a third theme should be a one-file
  change in `theme.typ`.
- **Never hardcode pixel paddings or absolute positions.** Use
  `1fr`, `auto`, `em`, `%`. The deck must reflow cleanly when a
  slide's body grows.
- **Keep the slide-kind set small.** A new slide kind earns its
  place only when at least two real decks would use it.
- **Keep `lib.typ` content-agnostic.** Anything specific to a
  particular subagent, skill, or workflow belongs in the consumer
  deck, not here.

## Provenance

This template is a port of [mole/docs/presentation-template/][mole]
(MIT, same author). The structural code (slide kinds, atoms,
notes mode, chrome footer) is unchanged; the palette is swapped
from melissa (warm honey, Mole's house style) to cyprus / bio
(green, the opencode-setup identity).

[mole]: https://github.com/felipebalbi/mole/tree/main/docs/presentation-template
