// slides.typ -- "opencode and Multi-agent Workflows".
//
// Compile (from this directory):
//   make                  -> slides.pdf (cyprus-light)
//   make notes            -> slides-notes.pdf (with speaker notes)
//   make dark             -> slides-dark.pdf (bio-dark)
//
// Or directly:
//   typst compile --root .. slides.typ
//   typst compile --root .. --input theme=dark slides.typ
//   typst compile --root .. --input notes=true slides.typ

#import "../presentation-template/lib.typ": *

#set page(
  paper: "presentation-16-9",
  margin: (x: 6%, y: 5%),
  fill: bg-page,
)

#set text(
  font: font-sans,
  size: 18pt,
  fill: ink,
)

#show raw: set text(font: font-mono, size: 15pt, fill: ink)
#show raw.where(block: true): it => code-chrome-block(
  text(fill: ink, it),
)

#include "chapters/00-cover.typ"
#include "chapters/01-why-opencode.typ"
#include "chapters/02-installing.typ"
#include "chapters/03-installing-opencode-setup.typ"
#include "chapters/04-what-you-got.typ"
#include "chapters/05-customising.typ"
#include "chapters/06-why-personas.typ"
#include "chapters/07-anatomy.typ"
#include "chapters/08-the-eight.typ"
#include "chapters/09-invocation.typ"
#include "chapters/10-authoring.typ"
#include "chapters/11-cost-discipline.typ"
#include "chapters/12-anti-patterns.typ"
#include "chapters/13-recap.typ"
