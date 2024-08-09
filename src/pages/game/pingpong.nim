import std/[os, strutils]
import ../../generator, ../../css/styles

const
    ballWidth: string = "15px"

    maxCatWidth: string = "200px"
    maxCatHeight: string = "300px"

    maxTableWidth: string = "300px"
    maxTableHeight: string = "200px"

    itemsWidth: string = "30%"

var html: HtmlDocument = newHtmlPage(
    "Cat Ping-Pong",
    "Cats playing fucking Ping-Pong!!!!",
    "game/pingpong.html",
    includeInMenuBar = false
)

html.addToHead(
    importScript("../javascript/game/pingpong.js").addattr("defer"),
    og("image", "../resources/images/games/pingpong/cat/pong.png")
)

# Preload images:
var paths: seq[string]
for path in walkDirRec("nirokay.com/resources/images/games/pingpong/"):
    if path.dirExists(): continue
    if not path.fileExists(): continue
    paths.add path
for path in paths:
    let href: string = path.replace("nirokay.com", "..")
    html.addToHead("link"[
        "rel" => "preload",
        "href" => href,
        "as" => "image"
    ])

html.add(
    header(
        h1("Cat Ping-Pong"),
        p("Bored of coin flipping? Me too: " & $i($b("CATS PLAYING PING-PONG!")))
    ),
    article(
        `div`(
            button("Start game", "game();").addattr("id", "id-button-start-game")
        ).setClass(classFlexContainer),
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
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            img("-", "Ball Left - Game Over").add(
                attr("id", "id-ball-left-game-over"),
                attr("style", "max-width:" & ballWidth & ";align-self:end;")
            ),
            # -----------------------------------------------------------------
            img("-", "Left cat").add(
                attr("id", "id-cat-left-picture"),
                attr("style", "max-height:" & maxCatHeight & ";max-width:" & maxCatWidth & ";width:" & itemsWidth & ";")
            ),
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            img("-", "Ball Left").add(
                attr("id", "id-ball-left"),
                attr("style", "max-width:" & ballWidth & ";align-self:baseline;")
            ),
            # =================================================================
            img("../resources/images/games/pingpong/table.png", "Ping pong table").addattr(
                "style",
                "max-height:" & maxTableHeight & ";max-width:" & maxTableWidth & ";width:" & itemsWidth & ";"
            ),
            # =================================================================
            img("-", "Ball Right").add(
                attr("id", "id-ball-right"),
                attr("style", "max-width:" & ballWidth & ";align-self:baseline;")
            ),
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            img("-", "Right cat").add(
                attr("id", "id-cat-right-picture"),
                attr("style", "max-height:" & maxCatHeight & ";max-width:" & maxCatWidth & ";width:" & itemsWidth & ";transform:scaleX(-1);")
            ),
            # -----------------------------------------------------------------
            img("-", "Ball Right - Game Over").add(
                attr("id", "id-ball-right-game-over"),
                attr("style", "max-width:" & ballWidth & ";align-self:end;")
            )
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        ).setClass(classFlexContainer).add(
            attr("style", "align-items:end;min-height:400px;"),
        )
    )
)

incl html
