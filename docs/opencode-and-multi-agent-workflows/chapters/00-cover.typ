#import "../../presentation-template/lib.typ": *

// 00-cover.typ -- cover + opening promise.

#cover-slide(
  "opencode",
  "Multi-agent workflows in your terminal.",
  "Felipe Balbi",
  "2026",
)

#section-slide("0", "What you'll leave with")

#content-slide("The promise")[
  #bullets(
    [What opencode is, and why a terminal coding agent earns its
     keep over raw chat.],
    [How to install opencode on Linux and Windows, and how to
     install the `opencode-setup` baseline on top of it.],
    [What `opencode-setup` actually ships: agents, a plugin, a
     config baseline --- and how to override any of it without
     editing the upstream.],
    [How the eight subagent personas work, how to invoke them,
     and how to write one the router will actually reach for.],
  )
  #note[
    Frame this as 45 minutes, including questions. The deck ends
    with a starter persona file the audience can copy on Monday.
  ]
]
