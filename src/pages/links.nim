import ../generator

var html: HtmlDocument = newHtmlPage(
    "Links",
    "Links to all my socials.",
    "links.html"
)

html.add(
    header(
        h1("Links"),
        p("Links to all my socials.")
    )
)

incl html
