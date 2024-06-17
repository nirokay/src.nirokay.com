import std/[tables]
import ../../generator
import ../types

const
    idFoodCheckbox: string = "i-would-give-food-to-findus"
    idCreditCardCheckbox: string = "oh-hell-yeah-lets-go"
    idCreditCardStealer: string = "gimme-gimme-more-gimme-gimme-gimme-more"
    idTestPassed: string = "good-person"
    idTestFailed: string = "bad-person"

const strings = (
    meta: (
        title: toTable {
            enGB: "Findus Love Calculator",
            deDE: "Findus Liebes-Rechner"
        },
        desc: toTable {
            enGB: "Silly game to determine if Findus, the cat, loves you.",
            deDE: "Dummes Spiel, das ausrechnet, ob Findus, der Kater, dich liebt."
        },
        file: toTable {
            enGB: "en.html",
            deDE: "de.html"
        }
    ),
    request: (
        legend: toTable {
            enGB: "Please tick the correct boxes:",
            deDE: "Bitte kreuze die zutreffenden Felder an:"
        },
        typeHere: toTable {
            enGB: "Please type it in here :)",
            deDE: "Bitte hier eingeben :)"
        }
    ),
    response: (
        submit: toTable {
            enGB: "Submit",
            deDE: "Einreichen"
        },
        passed: toTable {
            enGB: "YIPPIE! Findus loves you a lot! Good job on that!!! :3",
            deDE: "YIPPIE! Findus liebt dich sehr! Gute Arbeit!!! :3"
        },
        failed: toTable {
            enGB: "Ew, Findus finds you disgusting. Please work on yourself to become a better person...",
            deDE: "Igitt, Findus findet dich eklig. Bitte arbeite an deiner Persönlichkeit, um ein besserer Mensch zu werden..."
        }
    ),
    question: (
        loveCats: toTable {
            enGB: "Do you like cats?",
            deDE: "Magst du Katzen?"
        },
        catsLoveYou: toTable {
            enGB: "Do you think cats like you?",
            deDE: "Denkst du, dass Katzen dich mögen?"
        },
        catsBetterThanDogs: toTable {
            enGB: "Cats are superior to dogs.",
            deDE: "Katzen sind Hunden überlegen."
        },
        triedCatFood: toTable {
            enGB: "Have you tried cat food before?",
            deDE: "Hast du schonmal Katzenfutter probiert?"
        },
        wouldGiveFood: toTable {
            enGB: "Would you give food to Findus?",
            deDE: "Würdest du Findus füttern?"
        },
        financialSituation: toTable {
            enGB: "Is your financial situation stable?",
            deDE: "Ist dein finanzieller Status stabil?"
        },
        creditCardQuestion: toTable {
            enGB: "Would you provide your credit card information on a random internet questionnaire?",
            deDE: "Würdest du deine Kreditkarteninformationen in einem Internetfragebogen preisgeben?"
        },
        creditCardRequest: toTable {
            enGB: "", # "Very cool! Please provide your credit card credentials:",
            deDE: "" # "Sehr geil! Bitte gebe deine Kreditkarteninformationen an:"
        }
    )
)

type QuestionType* = enum
    yesNo, yesNoTypeMore, typingShort

var questionCounter: int = 0
proc question(question: LanguageString, questionType: QuestionType = yesNo, id: string = ""): HtmlElement =
    let
        questionName: string = "question_" & $questionCounter
        inputType: string = (
            case questionType:
            of yesNo, yesNoTypeMore: "checkbox"
            of typingShort: "text"
        )
    var
        input = "input"[
            "type" => inputType,
            "name" => questionName
        ]
        label = "label"[
            "for" => questionName
        ]
    if id != "": input.tagAttributes.add(attr("id", id))
    if inputType == "text": input.addattr("placeholder", $strings.request.typeHere)
    input.content = $question
    label.content = $input
    result = `div`(label)
    inc questionCounter

var
    htmlEN: HtmlDocument
    htmlDE: HtmlDocument

proc `->`(htmlTarget: var HtmlDocument, htmlSource: HtmlDocument) =
    htmlTarget = htmlSource
    htmlTarget.file = "game/findus/" & $strings.meta.file

for language in Language:
    setTranslationTarget(language)
    var html: HtmlDocument = newHtmlPage(
        $strings.meta.title,
        $strings.meta.desc,
        $strings.meta.file,
        includeInMenuBar = false
    )
    html.addToHead(
        importScript("/javascript/game/findus.js").addattr("defer")
    )
    html.add(
        header(
            h1($strings.meta.title),
            p($strings.meta.desc)
        ),
        article(
            dialog(false,
                p($strings.response.passed),
                img("/resources/images/games/findus/success.jpg", "Image success").addattr("width", "200px")
            ).addattr("id", idTestPassed),
            dialog(false,
                p($strings.response.failed),
                img("/resources/images/games/findus/failure.jpg", "Image failure").addattr("width", "200px")
            ).addattr("id", idTestFailed),
            fieldset(
                legend($strings.request.legend),
                # Cat questions:
                question strings.question.loveCats,
                question strings.question.catsLoveYou,
                question strings.question.catsBetterThanDogs,
                question strings.question.triedCatFood,
                question(strings.question.wouldGiveFood,
                    id = idFoodCheckbox
                ),
                # Money scam shit: -v-
                question strings.question.financialSituation,
                question(strings.question.creditCardQuestion,
                    id = idCreditCardCheckbox
                ),
                question(strings.question.creditCardRequest,
                    questionType = typingShort,
                    id = idCreditCardStealer
                ),
                button($strings.response.submit, "submitForm();")
            )
        )
    )
    case language:
    of enGB: htmlEN -> html
    of deDE: htmlDE -> html


incl htmlEN
incl htmlDE
