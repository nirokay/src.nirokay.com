import std/[]
import ../../generator, ../../css/styles

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
    article(
        `div`(
            h1("0").add(
                attr("id", "id-cat-left-score"),
                attr("style", "scale:3;")
            ),
            h2(":"),
            h1("0").add(
                attr("id", "id-cat-right-score"),
                attr("style", "scale:3;")
            )
        ).setClass(classFlexContainer).add(
            attr("style", "margin:20px;")
        ),
        `div`(
            img("", "Left cat").add(
                attr("id", "id-cat-left-picture"),
                attr("style", "max-height:400px;max-width:200px;")
            ),
            img("../resources/images/games/pingpong/table.png", "Ping pong table").addattr("style", "max-height:200px;max-width:200px;"),
            img("", "Right cat").add(
                attr("id", "id-cat-right-picture"),
                attr("style", "max-height:400px;max-width:200px;transform:scaleX(-1);")
            )
        ).setClass(classFlexContainer).add(
            attr("align-items", "center")
        )
    )
)

incl html
