import std/[os, strutils]
import ../../css/styles
import generator

const
    canvasWidth: int = 400
    canvasHeight: int = 500

var html: HtmlDocument = newHtmlUniversalPage(
    "Pop Cat",
    "Feed Pop Cat with food that is falling down from the sky!",
    "popcat"
)

html.addToHead(
    importScript(true, "../javascript/game/popcat.js"),
    ogImage("../resources/images/games/popcat/cat/open.png")
)

html.add(
    article(
        `div`(
            button("button", onclick = "popcatGameHasRestarted();", html "(Re-)Start game").setId("id-button-start-game")
        ).setClass(classFlexContainer),
        `div`(
            newHtmlElement("canvas").add(
                "width" <=> $canvasWidth,
                "height" <=> $canvasHeight
            ).setId("canvas").setStyle(
                "border" := "5px #e8e6e3 solid",
                "border-radius" := "20px"
            )
        ).setStyle(
            "margin" := "auto",
            "text-align" := "center"
        )
    )
)

incl html
