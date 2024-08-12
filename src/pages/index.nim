import ../generator, ../css/styles

var html: HtmlDocument = newHtmlPage(
    "Home",
    "Welcome to my little homepage!",
    "index.html"
)

html.add(
    header(
        h1("nirokay.com"),
        p("Welcome to my little homepage!").setClass(classGradientTextRainbow).attrStyle(
            "width" := "fit-content",
            "margin" := "auto"
        )
    ),
    article()
)

incl html
