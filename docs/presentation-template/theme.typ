// theme.typ -- color tokens for the opencode-setup presentation
// template.
//
// Two themes ship out of the box, both lifted from Protesilaos
// Stavrou's ef-themes (https://github.com/protesilaos/ef-themes):
//
//   cyprus-light  -- warm cream paper, cypress-green ink, deep
//                    green accent. The opencode-setup house style.
//   bio-dark      -- warm near-black paper, cool sage-green ink,
//                    bright sea-green accent. Same hue family,
//                    inverted lightness.
//
// Both palettes are green-forward by design: opencode-setup is
// about an agentic workflow ("a garden of specialists"), and the
// identity reads as cypress / forest / sea-green throughout.
//
// Tokens follow ef-themes naming so the source of every color is
// obvious:
//
//   bg-main / bg-dim / bg-alt          background tiers
//   fg-main / fg-dim / fg-alt          foreground tiers
//   <hue>                              ink color (red, blue, ...)
//   bg-<hue>-subtle                    panel fill for that hue
//
// The `callout` sub-dict maps a semantic kind (`info`, `warn`,
// `success`, `danger`) to a (fill, ink) pair drawn from the
// palette above. lib.typ's `callout` and `pill` look up directly
// from this dict -- no alpha math, no derived colors.

// ---- cyprus-light -------------------------------------------------
//
// Source palette: ef-cyprus. Warm cream paper, dark cypress-green
// ink, deep forest-green accent. The deck's visual signature is
// the deep green; `accent` is `green` (cypress) and `secondary` is
// `cyan-cooler` (deep teal), so the cool half stays distinct from
// the warm chrome.
#let cyprus-light = (
  // Background tiers.
  bg-main:    rgb("#fcf7ef"),  // warm cream paper
  bg-dim:     rgb("#f0ece0"),  // dimmer cream panel
  bg-alt:     rgb("#e5e3d8"),  // cover + code background

  // Foreground tiers.
  fg-main:    rgb("#242521"),  // near-black ink
  fg-dim:     rgb("#59786f"),  // muted cypress; body text
  fg-alt:     rgb("#7f475a"),  // warm plum; asides

  // Named hues (ink usage).
  red:        rgb("#9f0d0f"),
  green:      rgb("#006f00"),
  yellow:     rgb("#a7601f"),  // warm ochre, body-tier
  blue:       rgb("#375cc6"),
  magenta:    rgb("#9a456f"),
  cyan:       rgb("#1f70af"),

  // Subtle backgrounds (panel fills paired with the matching hue).
  bg-red-subtle:     rgb("#ffc6bf"),
  bg-green-subtle:   rgb("#c4f2af"),
  bg-yellow-subtle:  rgb("#f0f07f"),
  bg-blue-subtle:    rgb("#ccdfff"),
  bg-magenta-subtle: rgb("#fad3ff"),
  bg-cyan-subtle:    rgb("#bfefff"),

  // Identity accents. The deck's visual signature is cypress green;
  // `accent` is held distinct from `green` so the latter can be
  // used as the callout / "success" ink at body-text contrast.
  accent:     rgb("#006f00"),  // green -- cypress
  secondary:  rgb("#007a9f"),  // cyan-cooler -- deep teal

  // Chrome / asides.
  muted:        rgb("#59786f"),  // fg-dim -- muted cypress
  muted-light:  rgb("#9aa89e"),  // chrome / page number
  divider:      rgb("#c4c0b6"),  // border

  // Callout lookup: kind -> (fill, ink). Both values come straight
  // from the palette above; no derived colors.
  callout: (
    info:    (fill: rgb("#ccdfff"), ink: rgb("#375cc6")),
    warn:    (fill: rgb("#f0f07f"), ink: rgb("#a7601f")),
    success: (fill: rgb("#c4f2af"), ink: rgb("#006f00")),
    danger:  (fill: rgb("#ffc6bf"), ink: rgb("#9f0d0f")),
  ),
)

// ---- bio-dark -----------------------------------------------------
//
// Source palette: ef-bio. Warm near-black paper, cool sage-green
// ink, bright sea-green accent. Subtle backgrounds are deep
// desaturated variants of each hue -- no lightened pastels.
#let bio-dark = (
  // Background tiers.
  bg-main:    rgb("#111111"),  // warm near-black paper
  bg-dim:     rgb("#222522"),  // dimmer warm panel
  bg-alt:     rgb("#303230"),  // cover + code background

  // Foreground tiers.
  fg-main:    rgb("#cfdfd5"),  // cool sage
  fg-dim:     rgb("#808f80"),  // body text; muted sage
  fg-alt:     rgb("#8fcfaf"),  // sea-green; asides

  // Named hues (ink usage on dark bg -- brighter than light theme).
  red:        rgb("#ef6560"),
  green:      rgb("#3fb83f"),
  yellow:     rgb("#d4aa02"),
  blue:       rgb("#37aff6"),
  magenta:    rgb("#d38faf"),
  cyan:       rgb("#6fc5ef"),

  // Subtle backgrounds (deep desaturated variants -- panels stay
  // visibly darker than bg-main while keeping the hue identity).
  bg-red-subtle:     rgb("#65201a"),
  bg-green-subtle:   rgb("#0a4425"),
  bg-yellow-subtle:  rgb("#523324"),
  bg-blue-subtle:    rgb("#1a3863"),
  bg-magenta-subtle: rgb("#572853"),
  bg-cyan-subtle:    rgb("#113e57"),

  // Identity accents. Bright sea-green / sage on near-black.
  accent:     rgb("#00c089"),  // green-cooler -- bright sea-green
  secondary:  rgb("#5dc0aa"),  // cyan-cooler -- bright teal

  // Chrome / asides.
  muted:        rgb("#8fcfaf"),  // fg-alt -- sea-green
  muted-light:  rgb("#525959"),  // chrome / page number
  divider:      rgb("#525959"),  // border

  // Callout lookup: kind -> (fill, ink). Both values come straight
  // from the palette above; no derived colors.
  callout: (
    info:    (fill: rgb("#1a3863"), ink: rgb("#37aff6")),
    warn:    (fill: rgb("#523324"), ink: rgb("#d4aa02")),
    success: (fill: rgb("#0a4425"), ink: rgb("#3fb83f")),
    danger:  (fill: rgb("#65201a"), ink: rgb("#ef6560")),
  ),
)

// ---- Selection ----------------------------------------------------
//
// Pick a theme at compile time:
//   typst compile slides.typ                    -> cyprus-light
//   typst compile --input theme=dark slides.typ -> bio-dark
//
// Any unrecognised name falls through to cyprus-light so a typo
// renders something legible rather than crashing.
#let theme-name = sys.inputs.at("theme", default: "light")
#let active = if theme-name == "dark" {
  bio-dark
} else {
  cyprus-light
}
