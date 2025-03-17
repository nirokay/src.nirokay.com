import std/[tables, strutils, strformat, options]
import ../../generator, ../../snippets, ../../resources, ../../css/styles
import ../types

const
    idThesisDivPrefix: string = "id-thesis-div-"
    idThesisButtonsDiv: string = "id-thesis-buttons-"
    idThesisQuotePrefix: string = "id-thesis-quote-"
    idThesisAuthorPrefix: string = "id-thesis-author-"
    idThesisButtonAfdPrefix: string = "id-thesis-button-afd-"
    idThesisButtonOtherPrefix: string = "id-thesis-button-other-"

    idButtonStartQuestions: string = "id-button-start"
    idButtonSkipQuestion: string = "id-button-skip"
    idButtonNextQuestion: string = "id-button-next"


# Strings ---------------------------------------------------------------------

const strings = (
    meta: (
        title: lang("Who said what?", "Wer hat was gesagt?"),
        desc: lang(
            "Who said what? A depressing game about the re-rise of fascism in Germany.",
            "Wer hat was gesagt? Ein deprimierendes Spiel über den Wiederanstieg des Faschismus in Deutschland."
        ),
        file: lang("en.html", "de.html")
    ),
    data: (
        source: lang("Source", "Quelle"),
        sourceMissing: lang("Source missing", "Quelle fehlt"),
        authorUnknown: lang("Unknown", "Unbekannt"),
        authorImgAlt: lang("Image of author", "Bild des Authors"),
        question: lang("Was this said by a member of the AfD?", "Wurde das von einem AfD-Mitglied gesagt?"),
        button: (
            yes: lang("Yes", "Ja"),
            no: lang("No", "Nein"),
            start: lang("Start", "Starten"),
            skip: lang("Skip", "Überspringen"),
            next: lang("Next", "Weiter")
        )
    )
)

# CSS -------------------------------------------------------------------------

var css: CssStyleSheet = newCssStyleSheet("game/who-said-what/who-said-what-styles.css")

const
    classQuestionBlock = ".thesis-question-div"{
        "border-color" := colourText,
        "background-color" := colourBackgroundMiddle,
        "border-radius" := "20px",
        "border-style" := "solid",
        "border-width" := "3px",
        "margin" := "20px",
        "padding" := "20px"
    }
    classWrongAnswer = ".thesis-wrong-answer"{
        "border-color" := colourRed
    }
    classCorrectAnswer = ".thesis-correct-answer"{
        "border-color" := colourGreen
    }
    classButton = ".true-false-button"{
        "color" := $Black
    }

    classBullshitQuote = ".quote-bullshit"{
        "font-size" := "1.5em"
    }

    classAuthorImage = ".author-image"{
        "max-width" := "200px",
        "max-height" := "200px"
    }

css.add(
    classQuestionBlock,
    classWrongAnswer,
    classCorrectAnswer,

    classButton,

    classBullshitQuote,

    classAuthorImage
)


# HTML ------------------------------------------------------------------------

var
    htmlEN: HtmlDocument
    htmlDE: HtmlDocument
proc `->`(htmlTarget: var HtmlDocument, htmlSource: HtmlDocument) =
    htmlTarget = htmlSource
    htmlTarget.file = "game/who-said-what/" & $strings.meta.file

proc getAuthor(thesis: WhoSaidWhatThesis): WhoSaidWhatAuthor =
    result = block:
        if whoSaidWhatJson.authors.hasKey(thesis.author):
            whoSaidWhatJson.authors[thesis.author]
        else:
            WhoSaidWhatAuthor()
proc getAuthorDiv(thesis: WhoSaidWhatThesis, id: int): HtmlElement =
    let author: WhoSaidWhatAuthor = thesis.getAuthor()
    let imgUrl: string = block:
        let path: string = author.imageUrl.get("unknown.svg")
        if path.startsWith("https://") or path.startsWith("http://") or path.startsWith("/"):
            path
        else:
            "/resources/images/games/who-said-what/" & path

    let allegiances: string = block:
        if author.allegiances.len() == 0:
            ""
        else:
            ": " & $i(author.allegiances.join(", "))

    let source: HtmlElement = p(
        if thesis.source.strip() == "":
            $strings.data.sourceMissing
        else:
            $a(thesis.source, $strings.data.source)
    )

    result = `div`(
        img(imgUrl, $strings.data.authorImgAlt).setClass(classAuthorImage),
        p(thesis.author & allegiances),
        source
    ).setId(idThesisAuthorPrefix & $id).addStyle("display" := "none")

proc thesisHtmlBlock(id: int, thesis: WhoSaidWhatThesis): HtmlElement =
    let
        quote: LanguageString = lang(thesis.enGB, thesis.deDE)
        authorDiv: HtmlElement = thesis.getAuthorDiv(id)

        afdQuote: bool = block:
            var yes: bool = false
            for allegiance in thesis.getAuthor().allegiances:
                if allegiance.toLower() in ["afd", "ex-afd"]: yes = true
            yes

        buttonFunctionCorrect: string = &"submitQuestion({id}, {true});"
        buttonFunctionIncorrect: string = &"submitQuestion({id}, {false});"

        buttonWasSaidByAfd: string = if afdQuote: buttonFunctionCorrect else: buttonFunctionIncorrect
        buttonWasNotSaidByAfd: string = if not afdQuote: buttonFunctionCorrect else: buttonFunctionIncorrect

    result = `div`(
        q($quote).setId(idThesisQuotePrefix & $id).setClass(classBullshitQuote),
        `div`(
            authorDiv,
            `div`(
                p($strings.data.question),
                button($strings.data.button.yes, buttonWasSaidByAfd).addStyle("background-color" := colourGreen).setId(idThesisButtonAfdPrefix & $id).setClass(classButton),
                button($strings.data.button.no, buttonWasNotSaidByAfd).addStyle("background-color" := colourRed).setId(idThesisButtonOtherPrefix & $id).setClass(classButton)
            ).setId(idThesisButtonsDiv & $id)
        ).setClass(classFlexContainer).addStyle("align-items" := "center")
    ).setId(idThesisDivPrefix & $id).setClass(classQuestionBlock).addStyle("display" := "none")


for language in LANGUAGE:
    setTranslationTarget(language)
    var html: HtmlDocument = newHtmlPage(
        $strings.meta.title,
        $strings.meta.desc,
        $strings.meta.file,
        includeInMenuBar = false
    )
    block `overwrite funky css file name stuff lol`:
        let cssOverride: CssStyleSheet = newCssStyleSheet(css.file.split("/")[^1])
        html.setStylesheet(cssOverride)
    html.addToHead(
        importScript("/javascript/game/who-said-what.js").addattr("defer")
    )

    html.add(
        header(
            h1($strings.meta.title),
            p($strings.meta.desc),
            nav(
                button($strings.data.button.start, "whoSaidWhatStart();").setId(idButtonStartQuestions).addStyle("display" := "block"),
                button($strings.data.button.skip, "whoSaidWhatSkip();").setId(idButtonSkipQuestion).addStyle("display" := "none"),
                button($strings.data.button.next, "whoSaidWhatNext();").setId(idButtonNextQuestion).addStyle("display" := "none")
            ).setClass(classFlexContainer)
        )
    )

    var thesisList: seq[HtmlElement]
    for id, thesis in whoSaidWhatJson.thesis:
        thesisList.add thesisHtmlBlock(id, thesis)

    html.add(
        article(
            thesisList
        )
    )

    case language:
    of enGB: htmlEN -> html
    of deDE: htmlDE -> html



incl htmlEN
incl htmlDE
incl css
