import ../generator as GENERATOR
import classes, colours
export classes, colours

var globalCssTemplate*: CssStyleSheet = GENERATOR.newCssStyleSheet("---global-css---")
globalCssTemplate.add(
    "html"{
        "color" := colourText,
        "background-color" := colourBackgroundDark,
        "font-family" := "Verdana, Geneva, Tahoma, sans-serif"
    },
    "h1, h2"{
        "text-align" := "center"
    },
    "h3, h4, h5, h6"{
        "text-align" := "left"
    },
    "header > p"{
        "text-align" := "center"
    },
    "article > p"{
        "text-align" := "left"
    },
    "img"{
        "border-radius" := "10px"
    },
    "li"{
        "list-style-type" := "'👉'"
    },
    "select"{
        "margin" := "20px",
        "border-radius" := "10px",
        "background-color" := colourBackgroundLight,
        "color" := colourText,
        "border" := "3px solid " & colourBackgroundLight
    },
    "dialog"{
        "color" := colourText,
        "background-color" := colourBackgroundMiddle,
        "border-radius" := "10px",
        "border-color" := colourBackgroundLight
    },
    classFlexContainer,
    classClickableImage,

    classCodeShowcaseContainer,
    classCodeShowcaseElement,

    classDivMenuBarContainer
)


# Links: ----------------------------------------------------------------------
proc link(which: string, colour: CssColour|string): CssElement = ("a:" & which){
    "color" := $colour,
    "text-decoration" := "none"
} ## Css thing constructor
globalCssTemplate.add(
    link("link", colourLinkDefault),
    link("visited", colourLinkVisited),
    link("hover", colourLinkHover),
    link("active", colourLinkClick)
)

# Progress bar: ---------------------------------------------------------------
globalCssTemplate.add(
    "progress"{
        "margin" := "auto 1px",
        "width" := "90%",
        "border-radius" := "10px"
    }
)
for i in ["-webkit-progress-bar", "-webkit-progress-value", "-moz-progress-bar"]:
    globalCssTemplate.add ("progress::" & i){
        "border-radius" := "10px",
        "background-color" := colourText
    }


# Button: ---------------------------------------------------------------------
for i in ["button", ".button"]:
    globalCssTemplate.add i{
        "color" := colourText,
        "margin" := "4px 2px",
        "font-size" := "20px",
        "transition" := "0.3s",
        "border-radius" := "6px",
        "display" := "inline-block",
        "border" := "none",
        "padding" := "10px 20px",
        "background-color" := rgba(255, 100, 255, 0.1),
        "cursor" := "pointer",
        "text-decoration" := "none",
        "text-align" := "center",
    }
globalCssTemplate.add(
    ".button:hover"{
        "transition" := "0.1s",
        "background-color" := rgba(255, 100, 255, 0.2),
    }
)

# Centering content inside three divs: ----------------------------------------
globalCssTemplate.add(
    classDivCenteringOuter,
    classDivCenteringMiddle,
    classDivCenteringInner
)

# Overrides: ------------------------------------------------------------------
proc newCssStyleSheet*(path: string): CssStyleSheet =
    ## Override for `websitegenerator.newCssStyleSheet(path)` to include global css variables
    result = GENERATOR.newCssStyleSheet(path)
    result.elements = globalCssTemplate.elements

