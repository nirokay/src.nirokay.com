import std/[tables, strutils, strformat, options]
import ../../resources, ../../css/styles
import generator

const
    # Questions:
    idThesisDivPrefix: string = "id-thesis-div-"
    idThesisButtonsDiv: string = "id-thesis-buttons-"
    idThesisQuotePrefix: string = "id-thesis-quote-"
    idThesisAuthorPrefix: string = "id-thesis-author-"
    idThesisButtonAfdPrefix: string = "id-thesis-button-afd-"
    idThesisButtonOtherPrefix: string = "id-thesis-button-other-"

    # Score:
    idScoreAbsoluteLeft: string = "id-score-absolute-left"
    idScoreAbsoluteRight: string = "id-score-absolute-right"

    idScoreUniqueLeft: string = "id-score-unique-left"
    idScoreUniqueMiddle: string = "id-score-unique-middle"
    idScoreUniqueRight: string = "id-score-unique-right"

    # Buttons:
    idButtonStartQuestions: string = "id-button-start"
    idButtonSkipQuestion: string = "id-button-skip"
    idButtonNextQuestion: string = "id-button-next"


# Strings ---------------------------------------------------------------------

const strings = (
    meta: (
        title: lang("Who said what?", "Wer hat was gesagt?"),
        desc: lang(
            @[ # First element (split by "\n" used for meta description)
                "Who said what, an AfD member or another fascist? A depressing game about the (re-)rise of fascism in Germany.",
                "The source to the quote is featured after submitting your answer. If you discover an error or would like to submit more quotes, feel free to " & $a("https://github.com/nirokay/src.nirokay.com/blob/master/resources/game/who-said-what.json", "send a pull request on GitHub") & "."
            ].join("\n"),
            @[
                "Wer hat was gesagt, ein AfD Mitglied oder ein anderer Faschist? Ein deprimierendes Spiel über den (Wieder-)Anstieg des Faschismus in Deutschland.",
                "Die Quelle des Zitats is nach dem Einreichen einer Antwort zu Sehen. Falls Sie einen Fehler bemerken oder ein weiteres Zitat einreichen wollen, können Sie gerne " & $a("https://github.com/nirokay/src.nirokay.com/blob/master/resources/game/who-said-what.json", "ein Pull-Request via GitHub senden") & "."
            ].join("\n")
        )
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
        ),
        score: (
            correctUnique: lang("Score non-repeating questions: ", "Punkte nicht-wiederholter Fragen: "),
            correctAbsolute: lang("Score all questions: ", "Punkte aller Fragen: ")
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
            $a(thesis.source, $strings.data.source).addattr("target", "_blank")
    )

    result = `div`(
        img(imgUrl, $strings.data.authorImgAlt).setClass(classAuthorImage),
        p(thesis.author & allegiances),
        source
    ).setId(idThesisAuthorPrefix & $id).setStyle("display" := "none")

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
                button($strings.data.button.yes, buttonWasSaidByAfd).setStyle("background-color" := colourGreen).setId(idThesisButtonAfdPrefix & $id).setClass(classButton),
                button($strings.data.button.no, buttonWasNotSaidByAfd).setStyle("background-color" := colourRed).setId(idThesisButtonOtherPrefix & $id).setClass(classButton)
            ).setId(idThesisButtonsDiv & $id)
        ).setClass(classFlexContainer).setStyle("align-items" := "center")
    ).setId(idThesisDivPrefix & $id).setClass(classQuestionBlock).setStyle("display" := "none")


for language in LANGUAGE:
    setTranslationTarget(language)
    var html: HtmlDocument = newHtmlLanguagedPage(
        $strings.meta.title,
        split($strings.meta.desc, "\n")[0],
        "who-said-what"
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
            `div`(
                p(
                    <$> $strings.data.score.correctAbsolute,
                    strong("0").setId(idScoreAbsoluteLeft),
                    <$> "/",
                    strong("0").setId(idScoreAbsoluteRight)
                ),
                p(
                    <$> $strings.data.score.correctUnique,
                    strong("0").setId(idScoreUniqueLeft),
                    <$> "/",
                    strong("0").setId(idScoreUniqueMiddle),
                    <$> "(",
                    <$> i("0").setId(idScoreUniqueRight),
                    <$> ")"
                )
            ).setClass(classFlexContainer),
            nav(
                button($strings.data.button.start, "whoSaidWhatStart();").setId(idButtonStartQuestions).setStyle("display" := "block"),
                button($strings.data.button.skip, "whoSaidWhatSkip();").setId(idButtonSkipQuestion).setStyle("display" := "none"),
                button($strings.data.button.next, "whoSaidWhatNext();").setId(idButtonNextQuestion).setStyle("display" := "none")
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

    generateHtml()


incl htmlEN
incl htmlDE
incl css
