import std/[os, strutils]
import ../../css/styles
import generator

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
    newHtmlElement("canvas").setId("canvas")
)

incl html
