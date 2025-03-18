import ../../generator as originalGenerator, ../types, ../../css/styles
export originalGenerator except newHtmlPage
export types

proc getHtmlLanguagedPagePath*(gameTitle: string, language: Language): string =
    result = "game/" & gameTitle & "/" & language.toUrlRepr() & ".html"
proc getHtmlUniversalPagePath*(gameTitle: string): string =
    result = "game/" & gameTitle & ".html"

proc newHtmlUniversalPage*(title, description, gameTitle: string, cssPath: string = ""): HtmlDocument =
    ## Override for games
    let pathGame: string = gameTitle.getHtmlUniversalPagePath()
    result = newHtmlPage(title, description, pathGame, false, cssPath)
proc newHtmlLanguagedPage*(title, description, gameTitle: string, cssPath: string = ""): HtmlDocument =
    ## Override for games, generates multiple languages
    let pathGame: string = gameTitle.getHtmlLanguagedPagePath(getTranslationTarget())
    result = newHtmlPage(title, description, pathGame, false, cssPath)

    # Return if language is not english, as only english language picker will be constructed:
    if getTranslationTarget() != enGB: return

    # Language picker page:
    let newPath: string = "game/" & gameTitle & ".html"
    var html: HtmlDocument = newHtmlPage("Pick Language", "Pick a language for the game", newPath, false)
    html.add(
        header(
            h1("Choose language"),
            p("Pick the language you want to use for the game/interactive media.")
        )
    )

    var buttonList: seq[HtmlElement]
    for language in Language:
        let lang: LanguageObject = language.get()
        var button: HtmlElement = a(
            gameTitle & "/" & lang.short & ".html",
            $pc(lang.flag & $br() & lang.long).addStyle("font-size" := "2em")
        )
        buttonList.add button

    html.add(
        article(
            `div`(buttonList).setClass(classFlexContainer)
        )
    )

    incl html

proc setAs*(htmlTarget: var HtmlDocument, htmlSource: HtmlDocument) =
    htmlTarget = htmlSource
    #htmlTarget.file = "game/" & htmlSource.file & "/" & getTranslationTarget().toUrlRepr() & ".html"

template generateHtml*(): untyped =
    ## Template for generating languaged HTML documents
    case language:
    of enGB: htmlEN.setAs(html)
    of deDE: htmlDE.setAs(html)

