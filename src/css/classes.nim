import ../generator
import colours

const
    # Centering divs (around every page): -------------------------------------
    menuBarHeight* = "72px"
    classDivCenteringOuter*: CssElement = ".div-centering-outer"{
        "position" := "absolute",
        "display" := "table",
        "width" := "100%",
        "height" := "100%",
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
