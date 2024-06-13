
import ../generator

var html: HtmlDocument = newHtmlPage(
    "Games",
    "Collection of games and other interactive media.",
    "games.html"
)



incl html

import game/[findus]
export findus
