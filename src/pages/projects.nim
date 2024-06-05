import std/[tables, options]
import ../generator
import ../resources
import ../css/styles

var html: HtmlDocument = newHtmlPage(
    "Projects",
    "Showcase of projects and links to documentation.",
    "projects.html"
)

html.add(
    header(
        h1("Projects"),
        p("This is a showcase of some of my projects and their code documentation.")
    )
)
proc linkTo(name, url: string): HtmlElement = a(url, "&lt;" & name & " /&gt;")
var docs: seq[HtmlElement]
for topic, elements in projectShowcase:
    var newElements: seq[HtmlElement]
    for element in elements:
        var e: seq[HtmlElement] = @[
            h3(element.name),
            p($b(element.name) & " " & element.desc)
        ]
        var items: seq[HtmlElement]

        items.add linkTo("Source", element.repo)
        if element.docs.isSome(): items.add linkTo("Docs", get element.docs)
        if items.len() != 0: e.add ul(items)
        newElements.add `div`(e).setClass(classCodeShowcaseElement)

    docs.add `div`(newElements)

html.add(
    article(docs)
)

incl html
