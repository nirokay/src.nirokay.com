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
        )
    ),
    article(
        section(
            h2("Welcome!"),
            p("Feel free to look around using the nav bar at the top! :3")
        ),
        section(
           h2("HzgShowAround"),
           p("🇩🇪 Für HzgShowAround, klicke einfach auf " & $a("/HzgShowAround/index.html", "diesen Hyperlink") & "!").setLang("de"),
           p("🇬🇧 If you are here for HzgShowAround, just click " & $a("/HzgShowAround/index.html", "this hyperlink") & "!").setLang("en"),
        )
    )
)

incl html
