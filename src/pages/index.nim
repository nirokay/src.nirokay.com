import ../generator, ../css/styles

var html: HtmlDocument = newHtmlPage(
    "Home",
    "Welcome to my little homepage!",
    "index.html"
)

html.add(
    header(
        h1("nirokay.com"),
        p("Welcome to my little homepage!").setClass(classGradientRainbowBackground).setClass(classGradientTextRainbow).addStyle(
            "width" := "fit-content",
            "margin" := "auto"
        ),
        p("If you are here for HzgShowAround, just click " & $a("/HzgShowAround/index.html", "this hyperlink!") & "!")
    ),
    article()
)

incl html
