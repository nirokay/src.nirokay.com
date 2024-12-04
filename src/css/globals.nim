import ../generator as GENERATOR
import classes, colours
export classes, colours

var globalCssTemplate*: CssStyleSheet = GENERATOR.newCssStyleSheet("---global-css---")

globalCssTemplate.add(
    # --- Global: -------------------------------------------------------------
    "html"{
        "color" := colourText,
        "background-color" := colourBackgroundDark,
        "font-family" := "Verdana, Geneva, Tahoma, sans-serif"
    },

    # --- Headers: ------------------------------------------------------------
    "h1, h2"{
        "text-align" := "center"
    },
    "h3, h4, h5, h6"{
        "text-align" := "left"
    },

    # --- Page layout: --------------------------------------------------------
    "header > p"{
        "text-align" := "center"
    },
    "article > p"{
        "text-align" := "left"
    },

    # --- Images: -------------------------------------------------------------
    "img"{
        "border-radius" := "10px",
        # "background-color" := colourBackgroundLight, # breaks transparent images
        "color" := colourTextGrey
    },

    # --- Lists: --------------------------------------------------------------
    "ul > li"{
        "list-style-type" := "'👉 '"
    },


    # --- User input: ---------------------------------------------------------
    "select"{
        "margin" := "20px",
        "border-style" := "solid",
        "border-radius" := "10px",
        "background-color" := colourBackgroundLight,
        "color" := colourText,
        "border" := "3px solid " & colourBackgroundLight
    },
    "textarea, input"{
        "color" := colourText,
        "background-color" := colourBackgroundLight,
        "border-style" := "solid",
        "border-radius" := "10px",
        "border-color" := colourBackgroundLight,
        "padding" := "5px 10px",
        "margin" := "4px 5px",
        "accent-color" := $colourPalettePrimary
    },

    # --- Output: -------------------------------------------------------------
    "dialog"{
        "color" := colourText,
        "background-color" := colourBackgroundMiddle,
        "border-radius" := "10px",
        "border-color" := colourBackgroundLight,
        "width" := "50%",
        "max-width" := "800px"
    },

    # --- Nerd stuff (computer): ----------------------------------------------
    "code > pre, samp > pre"{
        "color" := colourText,
        "background-color" := colourBackgroundTransparentDarken,
        "padding" := "10px",
        "border-radius" := "10px"
    },

    "pre > kbd"{
        "font-weight" := "bold"
    },
    "kbd"{
        "background-color" := colourBackgroundLight,
        "padding" := "5px",
        "border-radius" := "10px",
        "border-style" := "outset",
        "border-color" := colourBackgroundLight,
        "font-weight" := "bold"
    },

    # --- Quotes: --------------------------------------------------------
    "div:has(> blockquote)"{
        "background-color" := colourBackgroundLight,
        "margin" := "10px auto",
        "padding" := "15px",
        "border-radius" := "10px"
    },

    "blockquote p::before"{
        "content" := "'\\201C'",
    },
    "blockquote p::after"{
        "content" := "'\\201D'"
    },

    "blockquote > p"{
        "font-style" := "italic"
    },
    "blockquote + p"{
        "text-align" := "right"
    },

    "q"{
        "font-style" := "italic"
    },

    # --- Tables: -------------------------------------------------------------
    "th, td"{
        "padding" := "10px"
    },

    # --- Definitions: --------------------------------------------------------
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

    # --- Misc: ---------------------------------------------------------------
    "abbr"{
        "text-decoration-style" := "dotted"
    },
    "s"{
        "color" := colourTextGrey
    },

    # --- Fieldset: -----------------------------------------------------------
    "fieldset"{
        "background-color" := colourBackgroundTransparentLighten, #colourBackgroundTransparentDarken,
        "border-radius" := "10px"
    },
    "fieldset > legend"{
        "text-decoration" := "underline"
    },

    # --- Classes: ------------------------------------------------------------
    classFlexContainer,
    classClickableImage,

    classCodeShowcaseLanguageImage,
    classCodeShowcaseContainer,
    classCodeShowcaseElement,

    classDivMenuBarContainer
)


# Links: ----------------------------------------------------------------------
proc link(which: string, colour: CssColour|string, textDecoration: string = "none"): CssElement = ("a:" & which){
    "color" := $colour,
    "text-decoration" := textDecoration,
    "text-decoration-color" := colourText
} ## Css thing constructor
globalCssTemplate.add(
    link("link", colourLinkDefault),
    link("visited", colourLinkVisited),
    link("hover", colourLinkHover, "underline"),
    link("active", colourLinkClick, "underline")
)


# Progress bar and meter: -----------------------------------------------------
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
    },

    "meter"{
        "--background" := colourText,
        "--optimum" := $ForestGreen,
        "--sub-optimum" := $Gold,
        "--sub-sub-optimum" := $Crimson,

        "background" := "var(--background)",
        "border-radius" := "10px",
        "border-color" := colourText,
        "border-width" := "2px"
    },
    "meter::-webkit-meter-bar"{
        "background" := "var(--background)",
        "border-radius" := "10px",
        "border-color" := colourText,
        "border-width" := "2px"
    },

    "meter:-moz-meter-optimum::-moz-meter-bar"{
        "background" := "var(--optimum)"
    },
    "meter::-webkit-meter-optimum-value"{
        "background" := "var(--optimum)"
    },

    "meter:-moz-meter-sub-optimum::-moz-meter-bar"{
        "background" := "var(--sub-optimum)"
    },
    "meter::-webkit-meter-suboptimum-value"{
        "background" := "var(--sub-optimum)"
    },

    "meter:-moz-meter-sub-sub-optimum::-moz-meter-bar"{
        "background" := "var(--sub-sub-optimum)"
    },
    "meter::-webkit-meter-even-less-good-value"{
        "background" := "var(--sub-sub-optimum)"
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
    classGradientRainbowBackground,
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

