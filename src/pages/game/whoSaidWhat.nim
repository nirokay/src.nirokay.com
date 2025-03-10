import std/[tables, strutils, json]
import ../../generator, ../../snippets, ../../resources
import ../types


const strings = (
    meta: (
        title: lang("Who said what?", "Wer hat was gesagt?"),
        desc: lang(
            "Who said what? A depressing game about the re-rise of fascism in Germany.",
            "Wer hat was gesagt? Ein deprimierendes Spiel über den Wiederanstieg des Faschismus in Deutschland."
        ),
        file: lang("en.html", "de.html")
    ),
    comparison: ()
)


var
    htmlEN: HtmlDocument
    htmlDE: HtmlDocument
proc `->`(htmlTarget: var HtmlDocument, htmlSource: HtmlDocument) =
    htmlTarget = htmlSource
    htmlTarget.file = "game/ai-doctor-diagnosis/" & $strings.meta.file

for language in LANGUAGE:
    setTranslationTarget(language)
    var html: HtmlDocument = newHtmlPage(
        $strings.meta.title,
        $strings.meta.desc,
        $strings.meta.file,
        includeInMenuBar = false
    )

    case language:
    of enGB: htmlEN -> html
    of deDE: htmlDE -> html
