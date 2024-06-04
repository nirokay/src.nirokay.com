import ../generator

var html: HtmlDocument = newHtmlPage(
    "Projects",
    "Showcase of projects and links to documentation.",
    "projects.html"
)

html.add(
    header(
        h1("Projects"),
        p("This is a showcase of some of my projects and their code documentation.")
    ),
    article(

    )
)

incl html
