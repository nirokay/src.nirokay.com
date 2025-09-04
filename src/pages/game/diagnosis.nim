import std/[strutils, algorithm]
import ../../snippets
import generator

const
    urlObnoxiousCss: string = "https://tholman.com/obnoxious/obnoxious.css"
    obnoxiousCssElement: string = "animated"
const
    idPageLanguage: string = "page-language-variable"
    idSectionStartQuiz: string = "section-start-quiz"
    idSectionQuiz: string = "section-doing-quiz"
    idSectionComputing: string = "section-computing-results"
    idSectionShowingResults: string = "section-showing-results"

    idLoadingText: string = "loading-text"
    idDiagnosisResultText: string = "diagnosis-result-text"

    idButtonStartQuiz: string = "button-quiz-start"
    idButtonSubmit: string = "button-quiz-submit"
    idButtonRetryQuiz: string = "button-quiz-retry"

    idQuizQuestionPrefix: string = "quiz-question-nr-"
    idQuizQuestionYouTrustEverythingOnTheInternetSuffix: string = "nah-scratch-that-this-stays-on"

const strings = (
    meta: (
        title: lang("A.I. Health Diagnosis", "K.I. Gesundheitsdiagnose"),
        desc: lang("✨ Super-duper blazingly fast AI tool to diagnose ANY illness, better than your doctor!! 🚀", "✨ Ultra super-duper schnelles KI Tool, um JEGLICHE Erkrankung zu diagnostizieren, besser als Ihr Arzt!! 🚀")
    ),
    button: (
        start: lang("Start quiz", "Quiz starten"),
        submit: lang("Calculate", "Berechnen"),
        retry: lang("Retry quiz", "Quiz neustarten")
    ),
    loading: lang("Computing...", "Berechnung läuft..."),
    diagnosis: (
        youHaveStart: lang(
            "According to our 99.999%<small>*</small> accurate diagnoses, you suffer from",
            "Laut unserer 99,999%<small>*</small> korrekten Diagnose, leiden Sie unter"
        ),
        youHaveEnd: lang(
            "<small>* <u>If we are mistaken (impossible), then you just had bad luck!</u></small>",
            "<small>* <u>Falls wir falsch liegen sollten (unmöglich), dann haben Sie halt Pech gehabt!</u></small>"
        )
    ),
    introduction: lang(
        @[
            "Our AI model is trained exclusively on legally-dubious acquired patient data from data brokers and health insurances. This allows us to provide you with a 99.999% accurate diagnosis!",
            "9/10 doctors recommend our service" & $sup("[Citation needed]") & "!"
        ].join("\n"),
        @[
            "Unser KI Modell ist exklusiv auf legal-fragwürdig beschaffenen Patienteninformation von Data Brokern und Gesundheitsversicherungen trainiert. Dies erlaubt uns Ihnen eine 99.999% korrekte Diagnosis zu Stellen!",
            "9 von 10 Ärzte empfehlen unser KI Modell" & $sup("[Quelle gebraucht]") & "!"
        ].join("\n")
    ),
    question: (
        instructions: lang(
            "Please submit the symptoms you are experiencing:",
            "Bitte kreuzen Sie die Symptome an, die Sie leiden lassen:"
        ),
        additionWriting: lang(
            "Feel free to elaborate on your symptoms, this will help our AI model to accurately diagnose you:",
            "Sie können weitere Symptome hier erläutern. Dies wird unserem KI Modell helfen, Sie besser zu diagnostizieren:"
        ),
        youTrustEverythingOnTheInternet: lang(
            "You trust everything on the internet.",
            "Sie glauben Alles, was im Internet steht."
        ),
        list: @[
            lang("Sneezing", "Niesen"),
            lang("Coughing", "Husten"),
            lang("Dizziness", "Schwindel"),
            lang("Headache", "Kopfschmerzen"),
            lang("Back pain", "Rückenschmerzen"),
            lang("Muscle pain", "Muskelschmerzen"),
            lang("Eye pain", "Augenschmerzen"),
            lang("Joint pain", "Gelenkschmerzen"),
            lang("Stomach pain", "Bauchschmerzen"),
            lang("Tooth pain", "Zahnschmerzen"),
            lang("Light sensitivity", "Lichtempfindlichkeit"),
            lang("Dry mouth", "Trockener Mund"),
            lang("Trembling", "Zittern"),
            lang("Ear pain", "Ohrenschmerzen"),
            lang("Abnormal sweating", "Abnormales Schwitzen"),
            lang("Abnormal heart rate", "Abnormale Herzfrequenz"),
            lang("Abnormal blood pressure", "Abnormaler Blutdruck"),
            lang("Diarrhea", "Durchfall"),
            lang("Hair loss", "Haarausfall"),
            lang("Itching", "Juckreiz"),
            lang("Tiredness", "Müdigkeit"),
            lang("Weight loss or gain", "Gewichtsabnahme oder -zunahme"),
            lang("Abnormal body temperature", "Abnormale Körpertemperatur"),
            lang("Vomiting", "Erbrechen"),
            lang("Anxiety", "Angstzustände"),
            lang("Flatulence", "Blähungen"),
            lang("Abnormal urine colour", "Abnormale Urinfarbe"),
            lang("Frequent urination", "Häufiges Urinieren")
        ]
    )
)

var
    htmlEN: HtmlDocument
    htmlDE: HtmlDocument

proc newQuestion(id, text: string, inputAttrs: seq[HtmlElementAttribute] = @[]): HtmlElement =
    result = `div`(
        label(id, "").add(
            input("checkbox", id).add(inputAttrs),
            rawText text
        )
    )

proc newButton(text: string, action: string): HtmlElement =
    result = `div`(
        button(text, action)
    ).setStyle(
        "margin" := "20px auto",
        "text-align" := "center"
    )

for language in Language:
    setTranslationTarget(language)
    var html: HtmlDocument = newHtmlLanguagedPage(
        $strings.meta.title,
        $strings.meta.desc,
        "ai-doctor-diagnosis"
    )
    html.setStylesheet(websitegenerator.newCssStyleSheet(urlObnoxiousCss))
    html.addToHead(
        importScript("/javascript/game/blazingly-fast-health-diagnosis.js").addattr("defer")
    )

    html.add( # Wtf is this monstrosity??
        `var`(
            case language:
            of enGB: "enGB"
            of deDE: "deDE"
        ).setId(idPageLanguage).setStyle(
            "display" := "none"
        )
    )

    var questionList: seq[LanguageString] = strings.question.list
    questionList.sort do (x, y: LanguageString) -> int:
        result = cmp(toLower($x), toLower($y))

    var questions: seq[HtmlElement] = @[]
    for questionCount, question in questionList:
        let id: string = idQuizQuestionPrefix & $questionCount
        questions.add newQuestion(id, $question)

    questions.add newQuestion(
        idQuizQuestionPrefix & idQuizQuestionYouTrustEverythingOnTheInternetSuffix,
        $strings.question.youTrustEverythingOnTheInternet,
        @[attr("checked")]
    )

    html.add(
        # Static header:
        header(
            h1($strings.meta.title),
            p($strings.meta.desc)
        ),

        # Semi-dynamic content:
        article(
            # Start quiz screen:
            `div`(
                pc($strings.introduction),
                newButton($strings.button.start, "startQuiz();").setId(idButtonStartQuiz)
            ).setId(idSectionStartQuiz).setStyle("display" := "initial"),

            # Quiz screen:
            `div`(
                fieldset(
                    @[legend($strings.question.instructions)] & questions
                ),
                newButton($strings.button.submit, "submitQuiz();").setId(idButtonSubmit)
            ).setId(idSectionQuiz).setStyle("display" := "none"),

            # Computing screen:
            `div`(
                h2($strings.loading).setId(idLoadingText).setClass(obnoxiousCssElement),
            ).setId(idSectionComputing).setStyle("display" := "none"),

            # Results display screen:
            `div`(
                pc($strings.diagnosis.youHaveStart),
                h2("???").setId(idDiagnosisResultText),
                pc($strings.diagnosis.youHaveEnd),
                newButton($strings.button.retry, "restartQuiz();").setId(idButtonRetryQuiz).setId(idButtonRetryQuiz)
            ).setId(idSectionShowingResults).setStyle("display" := "none")
        ).setStyle(
            "margin" := "50px 10%"
        )
    )

    generateHtml()

incl htmlEN
incl htmlDE
