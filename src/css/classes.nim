import ../generator
import colours

const
    # Centering divs (around every page): -------------------------------------
    classDivCenteringOuter*: CssElement = ".div-centering-outer"{
        "position" := "absolute",
        "display" := "table",
        "width" := "100%",
        "height" := "100%",
        "left" := "0",
        "top" := "0"
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

    # Links page: -------------------------------------------------------------
    classClickableImage*: CssElement = ".image-clickable-link"{
        "display" := "inline-flex",
        "margin" := "5px 5px",
        "padding" := "5px",
        "width" := "5rem",
        "max-width" := "150px"
    }
    classCodeShowcaseElement*: CssElement = ".code-showcase-element"{
        "display" := "inline-flex",
        "margin" := "5px 5px",
        "padding" := "5px",
        "width" := "45%",
        "max-width" := "400px",
        "background" := colourContentBox,
        "border-radius" := "10px",
        "padding" := "10px"
    }
    classFlexContainer*: CssElement = ".container-flex"{
        "text-align" := "center",
        #"max-height" := "150px",
        "display" := "flex",
        "align-items" := "baseline",
        "justify-content" := "space-evenly",
        "flex-wrap" := "wrap"
    }
