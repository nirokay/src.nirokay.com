import std/[strutils, strformat]
import cattag
import colours

const roundedCorners*: CssElementProperty = borderRadius := 15'px

proc newTextGradientClass*(className: string, colourLeft, colourRight: string|CssColour): CssElement =
    ## Generates a new text gradient CSS class
    result = newCssClass(className,
        background := &"linear-gradient(45deg, {colourLeft}, {colourRight})",
        backgroundClip := "text",
        "-webkit-background-clip" := "text",
        "-webkit-text-fill-color" := "transparent"
    )
proc newTextGradientRainbowBackgroundClass*(): CssElement =
    let colours: string = coloursGradientRainbow.join(", ")
    result = newCssClass("text-gradient-background-rainbow",
        background := "linear-gradient(to right, " & colours & ")"
    )
proc newTextGradientRainbowClass*(): CssElement =
    result = newCssClass("text-gradient-rainbow",
        #[
        # Should not be necessary:
        "background" := "red",
        "background" := "-webkit-linear-gradient(left, " & colours & ")",
        "background" := "-o-linear-gradient(right, " & colours & ")",
        "background" := "-moz-linear-gradient(right, " & colours & ")",
        ]#
        "-webkit-background-clip" := "text",
        "-webkit-text-fill-color" := "transparent",
        backgroundClip := "text"
    )


const
    # Centering divs (around every page): -------------------------------------
    menuBarHeight* = "72px"
    classDivCenteringOuter*: CssElement = newCssClass("div-centering-outer",
        position := "absolute",
        display := "table",
        width := "100%",
        height := "calc(100% - " & menuBarHeight & ")",
        left := "0",
        top := "calc(" & menuBarHeight & ")"
    )
    classDivCenteringMiddle*: CssElement = newCssClass("div-centering-middle",
        verticalAlign := "middle",
        display := "table-cell"
    )
    classDivCenteringInner*: CssElement = newCssClass("div-centering-inner",
        width := "100%",
        marginLeft := "auto",
        marginRight := "auto"
    )
    classDivMenuBarContainer*: CssElement = newCssClass("div-menu-bar-container",
        position := "fixed",
        display := "flex",
        width := "100%",
        height := menuBarHeight,
        left := "0",
        top := "0",
        paddingLeft := 10'px,
        backgroundColor := colourBackgroundMiddle
    )

    # Links page: -------------------------------------------------------------
    classClickableImage*: CssElement = newCssClass("image-clickable-link",
        display := "inline-flex",
        margin := "5px 5px",
        padding := "5px",
        width := "5rem",
        maxWidth := "150px"
    )
    classCodeShowcaseElement*: CssElement = newCssClass("code-showcase-element",
        display := "inline-block",
        margin := "5px 5px",
        padding := 5'px,
        width := 30'percent,
        maxWidth := 500'px,
        minWidth := 300'px,
        background := colourBackgroundMiddle,
        padding := 10'px,
        roundedCorners
    )
    classCodeShowcaseLanguageImage*: CssElement = newCssClass("code-showcase-language-image",
        maxHeight := 1'rem,
        borderRadius := 0'px
    )
    classFlexContainer*: CssElement = newCssClass("container-flex",
        textAlign := "center",
        display := "flex",
        alignItems := "baseline",
        justifyContent := "space-evenly",
        flexWrap := "wrap"
    )
    classCodeShowcaseContainer*: CssElement = newCssClass("container-code-showcase",
        alignItems := "center",
        display := "flex",
        flexWrap := "wrap",
        justifyContent := "center"
    )

    # Fancy text: -------------------------------------------------------------
    classGradientTextPrimaryToSecondary*: CssElement = newTextGradientClass("text-gradient-one", colourPalettePrimary, colourPaletteSecondary)
    classGradientTextSecondaryToTrinary*: CssElement = newTextGradientClass("text-gradient-two", colourPaletteSecondary, colourPaletteTrinary)
    classGradientRainbowBackground*: CssElement = newTextGradientRainbowBackgroundClass()
    classGradientTextRainbow*: CssElement = newTextGradientRainbowClass()
