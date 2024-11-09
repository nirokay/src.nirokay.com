import std/[strutils, strformat]
import ../generator
import colours


proc newTextGradientClass*(className: string, colourLeft, colourRight: string|CssColour): CssElement =
    ## Generates a new text gradient CSS class
    result = ("." & className){
        "background" := &"linear-gradient(45deg, {colourLeft}, {colourRight})",
        "background-clip" := "text",
        "-webkit-background-clip" := "text",
        "-webkit-text-fill-color" := "transparent"
    }
proc newTextGradientRainbowClass*(): CssElement =
    let colours: string = coloursGradientRainbow.join(", ")
    result = ".text-gradient-rainbow"{
        #[
        # Should not be necessarry:
        "background" := "red",
        "background" := "-webkit-linear-gradient(left, " & colours & ")",
        "background" := "-o-linear-gradient(right, " & colours & ")",
        "background" := "-moz-linear-gradient(right, " & colours & ")",
        ]#
        "background" := "linear-gradient(to right, " & colours & ")",
        "-webkit-background-clip" := "text",
        "-webkit-text-fill-color" := "transparent",
        "background-clip" := "text"
    }


const
    # Centering divs (around every page): -------------------------------------
    menuBarHeight* = "72px"
    classDivCenteringOuter*: CssElement = ".div-centering-outer"{
        "position" := "absolute",
        "display" := "table",
        "width" := "100%",
        "height" := "calc(100% - " & menuBarHeight & ")",
        "left" := "0",
        "top" := "calc(" & menuBarHeight & ")"
    }
    classDivCenteringMiddle*: CssElement = ".div-centering-middle"{
        "vertical-align" := "middle",
        "display" := "table-cell"
    }
    classDivCenteringInner*: CssElement = ".div-centering-inner"{
        "width" := "100%",
        "margin-left" := "auto",
        "margin-right" := "auto"
    }
    classDivMenuBarContainer*: CssElement = ".div-menu-bar-container"{
        "position" := "fixed",
        "display" := "flex",
        "width" := "100%",
        "height" := menuBarHeight,
        "left" := "0",
        "top" := "0",
        "padding-left" := "10px",
        "background-color" := colourBackgroundMiddle
    }

    # Links page: -------------------------------------------------------------
    classClickableImage*: CssElement = ".image-clickable-link"{
        "display" := "inline-flex",
        "margin" := "5px 5px",
        "padding" := "5px",
        "width" := "5rem",
        "max-width" := "150px"
    }
    classCodeShowcaseElement*: CssElement = ".code-showcase-element"{
        "display" := "inline-block",
        "margin" := "5px 5px",
        "padding" := "5px",
        "width" := "30%",
        "max-width" := "500px",
        "min-width" := "300px",
        "background" := colourBackgroundMiddle,
        "border-radius" := "10px",
        "padding" := "10px"
    }
    classCodeShowcaseLanguageImage*: CssElement = ".code-showcase-language-image"{
        "max-height" := "1rem",
        "border-radius" := "0px"
    }
    classFlexContainer*: CssElement = ".container-flex"{
        "text-align" := "center",
        "display" := "flex",
        "align-items" := "baseline",
        "justify-content" := "space-evenly",
        "flex-wrap" := "wrap"
    }
    classCodeShowcaseContainer*: CssElement = ".container-code-showcase"{
        "align-items" := "center",
        "display" := "flex",
        "flex-wrap" := "wrap",
        "justify-content" := "center"
    }

    # Fancy text: -------------------------------------------------------------
    classGradientTextPrimaryToSecondary*: CssElement = newTextGradientClass("text-gradient-one", colourPalettePrimary, colourPaletteSecondary)
    classGradientTextSecondaryToTrinary*: CssElement = newTextGradientClass("text-gradient-two", colourPaletteSecondary, colourPaletteTrinary)
    classGradientTextRainbow*: CssElement = newTextGradientRainbowClass()
