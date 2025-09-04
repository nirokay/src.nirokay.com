import generator

const
    idFoodCheckbox: string = "i-would-give-food-to-findus"
    idCreditCardCheckbox: string = "oh-hell-yeah-lets-go"
    idCreditCardStealer: string = "gimme-gimme-more-gimme-gimme-gimme-more"
    idTestPassed: string = "good-person"
    idTestFailed: string = "bad-person"

const strings = (
    meta: (
        title: lang("Findus Love Calculator", "Findus Liebes-Rechner"),
        desc: lang("Silly game to determine if Findus, the cat, loves you.", "Dummes Spiel, das ausrechnet, ob Findus, der Kater, dich liebt.")
    ),
    request: (
        legend: lang("Please tick the correct boxes:", "Bitte kreuze die zutreffenden Felder an:"),
        typeHere: lang("Please type it in here :)", "Bitte hier eingeben :)")
    ),
    response: (
        submit: lang("Submit", "Einreichen"),
        passed: lang("YIPPIE! Findus loves you a lot! Good job on that!!! :3", "YIPPIE! Findus liebt dich sehr! Gute Arbeit!!! :3"),
        failed: lang("Ew, Findus finds you disgusting. Please work on yourself to become a better person...", "Igitt, Findus findet dich eklig. Bitte arbeite an deiner Persönlichkeit, um ein besserer Mensch zu werden...")
    ),
    question: (
        loveCats: lang("Do you like cats?", "Magst du Katzen?"),
        catsLoveYou: lang("Do you think cats like you?", "Denkst du, dass Katzen dich mögen?"),
        catsBetterThanDogs: lang("Cats are superior to dogs.", "Katzen sind Hunden überlegen."),
        triedCatFood: lang("Have you tried cat food before?", "Hast du schonmal Katzenfutter probiert?"),
        wouldGiveFood: lang("Would you give food to Findus?", "Würdest du Findus füttern?"),
        financialSituation: lang("Is your financial situation stable?", "Ist dein finanzieller Status stabil?"),
        creditCardQuestion: lang("Would you provide your credit card information on a random internet questionnaire?", "Würdest du deine Kreditkarteninformationen in einem Internetfragebogen preisgeben?"),
        creditCardRequest: lang("", "")
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
        input = input(@[

            "type" <=> inputType,
            "name" <=> questionName
        ])
        label = label(@[
            "for" <=> questionName
        ])
    if id != "": input.add("id" <=> id)
    if inputType == "text": input.add(placeholder <=> $strings.request.typeHere)
    label.add(input, html($question))
    result = `div`(label)
    inc questionCounter

var
    htmlEN: HtmlDocument
    htmlDE: HtmlDocument

for language in Language:
    setTranslationTarget(language)
    var html: HtmlDocument = newHtmlLanguagedPage(
        $strings.meta.title,
        $strings.meta.desc,
        "findus"
    )
    html.addToHead(
        script(true, "/javascript/game/findus.js"),
        ogImage("/resources/images/games/findus/success.jpg")
    )
    html.add(
        header(
            h1(html $strings.meta.title),
            p(html $strings.meta.desc)
        ),
        article(
            dialog(false,
                p(html $strings.response.passed),
                img("/resources/images/games/findus/success.jpg", "Image success").addattr("width", "200px")
            ).addattr("id", idTestPassed),
            dialog(false,
                p(html $strings.response.failed),
                img("/resources/images/games/findus/failure.jpg", "Image failure").addattr("width", "200px")
            ).addattr("id", idTestFailed),
            fieldset(
                legend(html $strings.request.legend),
                # Cat questions
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
                button(strings.response.submit).addattr("onclick" <=> "submitForm();")
            )
        )
    )
    generateHtml()


incl htmlEN
incl htmlDE
