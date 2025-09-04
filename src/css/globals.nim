import cattag as GENERATOR
import classes, colours
export classes, colours

var globalCssTemplate*: CssStylesheet = GENERATOR.newCssStylesheet("---global-css---")

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
    "article > section"{
        roundedCorners,
        "background-color" := colourBackgroundMiddle,
        "margin" := "30px",
        "padding" := "20px"
    },
    "article > section :first-child"{
        "margin-top" := "0px !important"
    },
    "article > section :last-child"{
        "margin-bottom" := "0px !important"
    },

    # --- Images: -------------------------------------------------------------
    "img"{
        roundedCorners,
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
        "background-color" := colourBackgroundLight,
        "color" := colourText,
        "border" := "3px solid " & colourBackgroundLight,
        roundedCorners
    },
    "textarea, input"{
        "color" := colourText,
        "background-color" := colourBackgroundLight,
        "border-style" := "solid",
        "border-color" := colourBackgroundLight,
        roundedCorners,
        "padding" := "5px 10px",
        "margin" := "4px 5px",
        "accent-color" := $colourPalettePrimary
    },

    # --- Output: -------------------------------------------------------------
    "dialog"{
        "color" := colourText,
        "background-color" := colourBackgroundMiddle,
        "border-color" := colourBackgroundLight,
        roundedCorners,
        "width" := "50%",
        "max-width" := "800px"
    },

    # --- Nerd stuff (computer): ----------------------------------------------
    "code > pre, samp > pre"{
        "color" := colourText,
        "background-color" := colourBackgroundTransparentDarken,
        "padding" := "10px",
        roundedCorners
    },

    "pre > kbd"{
        "font-weight" := "bold"
    },
    "kbd"{
        "background-color" := colourBackgroundLight,
        "padding" := "5px",
        roundedCorners,
        "border-style" := "outset",
        "border-color" := colourBackgroundLight,
        "font-weight" := "bold"
    },

    # --- Quotes: --------------------------------------------------------
    "div:has(> blockquote)"{
        "background-color" := colourBackgroundLight,
        "margin" := "10px auto",
        "padding" := "15px",
        roundedCorners
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
    "table"{
        "background-color" := colourBackgroundMiddle,
        "padding" := "5px",
        roundedCorners
    },
    "th, td"{
        "padding" := "10px"
    },
    "thead > tr > th"{
        "background-color" := colourBackgroundLight,
        "text-align" := "start",
        roundedCorners
    },
    # --- Definitions: --------------------------------------------------------
    "dl"{
        "background-color" := colourBackgroundTransparentDarken,
        "padding" := "10px",
        roundedCorners
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
        roundedCorners
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
        "border-color" := colourText,
        "border-width" := "2px",
        roundedCorners
    },
    "progress::-webkit-progress-bar"{
        "background-color" := colourText,
        roundedCorners
    },
    "progress::-webkit-progress-value"{
        "background-color" := $colourPalettePrimary,
        roundedCorners
    },
    "progress::-moz-progress-bar"{
        "background-color" := $colourPalettePrimary,
        roundedCorners
    },

    "meter"{
        "--background" := colourText,
        "--optimum" := $ForestGreen,
        "--sub-optimum" := $Gold,
        "--sub-sub-optimum" := $Crimson,

        "background" := "var(--background)",
        "border-color" := colourText,
        "border-width" := "2px",
        roundedCorners
    },
    "meter::-webkit-meter-bar"{
        "background" := "var(--background)",
        "border-color" := colourText,
        "border-width" := "2px",
        roundedCorners
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
        "display" := "inline-block",
        "border" := "none",
        "padding" := "10px 20px",
        "background-color" := colourButton,
        "cursor" := "pointer",
        "text-decoration" := "none",
        "text-align" := "center",
        roundedCorners
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
proc newCssStylesheet*(path: string): CssStyleSheet =
    ## Override for `cattag.newCssStylesheet(path)` to include global css variables
    result = GENERATOR.newCssStylesheet(path)
    result.children = globalCssTemplate.children
