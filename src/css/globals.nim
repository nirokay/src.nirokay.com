import ../generator as GENERATOR
import classes
export classes

var globalCssTemplate*: CssStyleSheet = GENERATOR.newCssStyleSheet("---global-css---")
globalCssTemplate.add(
    "html"{
        "color" := "#e8e6e3",
        "background-color" := rgb(23, 25, 33),
        "font-family" := "Verdana, Geneva, Tahoma, sans-serif"
    },
    "h1, h2"{
        "text-align" := "center"
    },
    "header > p"{
        "text-align" := "center"
    }
)

proc newCssStyleSheet*(path: string): CssStyleSheet =
    result = GENERATOR.newCssStyleSheet(path)
    result.elements = globalCssTemplate.elements

