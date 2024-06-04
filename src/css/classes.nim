import ../generator

const
    # Centering divs (around every page):
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
