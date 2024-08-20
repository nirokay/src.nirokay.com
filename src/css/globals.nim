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
        "border-radius" := "10px",
        "color" := colourTextGrey
    },

    "ul > li"{
        "list-style-type" := "'👉 '"
    },

    "select"{
        "margin" := "20px",
        "border-radius" := "10px",
        "background-color" := colourBackgroundLight,
        "color" := colourText,
        "border" := "3px solid " & colourBackgroundLight
    },
    "textarea, input"{
        "color" := colourText,
        "background-color" := colourBackgroundLight,
        "border-radius" := "10px",
        "border-color" := colourBackgroundLight,
        "padding" := "5px 10px",
        "margin" := "4px 5px",
        "accent-color" := $colourPalettePrimary
    },

    "dialog"{
        "color" := colourText,
        "background-color" := colourBackgroundMiddle,
        "border-radius" := "10px",
        "border-color" := colourBackgroundLight,
        "width" := "50%",
        "max-width" := "800px"
    },

    "code > pre, samp > pre"{
        "color" := colourText,
        "background-color" := colourBackgroundTransparentDarken,
        "padding" := "10px",
        "border-radius" := "10px"
    },

    "dl"{
        "background-color" := colourBackgroundTransparentDarken,
        "padding" := "10px",
        "border-radius" := "10px"
    },
    "dl > dt"{
        "text-decoration" := "underline"
    },
    "dl > dd"{
        "color" := colourTextGrey
    },

    "abbr"{
        "text-decoration-style" := "dotted"
    },
    "s"{
        "color" := colourTextGrey
    },

    "fieldset"{
        "background-color" := colourBackgroundTransparentLighten, #colourBackgroundTransparentDarken,
        "border-radius" := "10px"
    },
    "fieldset > legend"{
        "text-decoration" := "underline"
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
        "border-radius" := "10px",
        "border-color" := colourText,
        "border-width" := "2px"
    },
    "progress::-webkit-progress-bar"{
        "background-color" := colourText,
        "border-radius" := "10px"
    },
    "progress::-webkit-progress-value"{
        "background-color" := $colourPalettePrimary,
        "border-radius" := "10px"
    },
    "progress::-moz-progress-bar"{
        "background-color" := $colourPalettePrimary,
        "border-radius" := "10px"
    }
)


# Button: ---------------------------------------------------------------------
for i in ["button", ".button"]:
    globalCssTemplate.add i{
        "color" := colourText,
        "margin" := "4px 2px",
        "font-size" := "20px",
        "transition" := "0.3s",
        "border-radius" := "10px",
        "display" := "inline-block",
        "border" := "none",
        "padding" := "10px 20px",
        "background-color" := colourButton,
        "cursor" := "pointer",
        "text-decoration" := "none",
        "text-align" := "center",
    }
    globalCssTemplate.add(
        (i & ":hover"){
            "transition" := "0.1s",
            "background-color" := colourButtonHover
        },
        (i & ":active"){
            "background-color" := colourButtonClick
        }
    )


# Fancy text stuff: -----------------------------------------------------------
globalCssTemplate.add(
    classGradientTextPrimaryToSecondary,
    classGradientTextSecondaryToTrinary,
    classGradientTextRainbow
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

