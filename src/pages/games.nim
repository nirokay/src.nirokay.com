import ../generator, ../css/styles, ../resources, ../snippets
import types
from ./game/generator import getHtmlLanguagedPagePath, getHtmlUniversalPagePath

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
    if game.universal.isSet():
        links.add(li a(game.title.getHtmlUniversalPagePath(), game.name))
    else:
        for language in Language:
            let lang: LanguageObject = language.get()
            links.add(li a(game.title.getHtmlLanguagedPagePath(language), lang.long))

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
    findus, pingpong, diagnosis, whoSaidWhat
]
export
    findus, pingpong, diagnosis, whoSaidWhat
