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
        h1(html"Games"),
        p(html"This is a collection of games and other interactive media.")
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
        h3(html game.name),
        p(html game.desc),
        ul(links)
    ).setClass(classCodeShowcaseElement)

html.add(
    article(
        `div`(gamesHtml).setClass(classCodeShowcaseContainer)
    )
)

incl html

import game/[
    findus, pingpong, diagnosis, whoSaidWhat, popcat
]
export
    findus, pingpong, diagnosis, whoSaidWhat, popcat
