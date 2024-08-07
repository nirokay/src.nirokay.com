import std/[]
import ../../generator

var html: HtmlDocument = newHtmlPage(
    "PingPong",
    "Cats playing fucking Ping-Pong!!!!",
    "game/pingpong.html",
    includeInMenuBar = false
)

html.addToHead importScript("../javascript/game/pingpong.js").addattr("defer") # /javascript/game/pingpong.js

html.add(
    header(
        h1("Cat Ping-Pong"),
        p("Bored of coin flipping? Me too: " & $i($b("CATS PLAYING PING-PONG!")))
    ),
    article()
)

incl html
