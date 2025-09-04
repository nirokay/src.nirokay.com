import std/[tables, options]
import ../generator
import ../resources
import ../css/styles

var html: HtmlDocument = newHtmlPage(
    "Projects",
    "Showcase of my projects and links to their documentation.",
    "projects.html"
)

html.add(
    header(
        h1(html"Projects"),
        p(html"This is a showcase of some of my projects and their code documentation.")
    )
)
proc linkTo(name, url: string): HtmlElement = li(html(
    $a(url, "&lt;" & name & " /&gt;").setClass(classGradientRainbowBackground).setClass(classGradientTextRainbow)
))
var docs: seq[HtmlElement]
for topic, elements in projectShowcase:
    if elements.len() == 0: continue
    docs.add h2(html topic)
    var newElements: seq[HtmlElement]
    for element in elements:
        let image: HtmlElement = img(
            "/resources/images/language/" & (
                case element.lang:
                of "nim": "nim.png"
                of "lua": "lua.png"
                else: "none.png"
            ),
            element.lang
        ).setClass(classCodeShowcaseLanguageImage)
        var e: seq[HtmlElement] = @[
            h3(html(element.name & " " & $image)),
            p(html($b(html element.name) & " " & element.desc))
        ]
        var items: seq[HtmlElement]

        items.add linkTo("Source", element.repo)
        if element.docs.isSome(): items.add linkTo("Docs", get element.docs)
        if items.len() != 0: e.add ul(items)
        newElements.add `div`(e).setClass(classCodeShowcaseElement)

    docs.add `div`(newElements).setClass(classCodeShowcaseContainer)

html.add(
    article(docs)
)

incl html
