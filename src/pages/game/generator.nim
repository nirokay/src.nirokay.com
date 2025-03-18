import std/[strutils]
import ../../generator, ../types
export generator, types

proc newHtmlLanguagedPage*(title, description, gameTitle: string, includeInMenuBar: bool = true, cssPath: string = ""): HtmlDocument =
    ## Override for games, generates
    result = newHtmlPage(title, description, gameTitle, includeInMenuBar, cssPath)

    let newPath: string = "game/" & gameTitle & ".html"
    var html: HtmlDocument = newHtmlPage("Pick Language", "Pick a language for the game", newPath, false)
    html.add h1("Pick a language")
    incl html

proc setAs*(htmlTarget: var HtmlDocument, htmlSource: HtmlDocument) =
    htmlTarget = htmlSource
    htmlTarget.file = "game/" & htmlSource.file & "/" & getTranslationTarget().toUrlRepr() & ".html"

template generateHtml*(): untyped =
    ## Template for generating languaged HTML documents
    case language:
    of enGB: htmlEN.setAs(html)
    of deDE: htmlDE.setAs(html)

