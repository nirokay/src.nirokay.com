import std/[tables]
import ../generator, ../css/styles, ../resources

var html: HtmlDocument = newHtmlPage(
    "Games",
    "Collection of games and other interactive media.",
    "games.html"
)

html.add(
    header(
        h1("Games"),
        p("This is a collection of games and other interactive media.")
    )
)

var gamesHtml: seq[HtmlElement]
for game in gamesJson:
    var links: seq[HtmlElement]
    for path, text in game.file:
        links.add li($a("games/" & path, text))
    gamesHtml.add `div`(
        h3(game.name),
        p(game.desc),
        ul(links)
    ).setClass(classCodeShowcaseElement)

html.add(
    article(
        `div`(gamesHtml).setClass(classCodeShowcaseContainer)
    )
)

incl html

import game/[
    findus
]
export
    findus
