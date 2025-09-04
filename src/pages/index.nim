import ../generator, ../css/styles

var html: HtmlDocument = newHtmlPage(
    "Home",
    "Welcome to my little homepage!",
    "index.html"
)

html.add(
    header(
        h1(html"nirokay.com"),
        p(html"Welcome to my little homepage!").setClass(classGradientRainbowBackground).setClass(classGradientTextRainbow).setStyle(
            width := "fit-content",
            margin := "auto"
        )
    ),
    article(
        section(
            h2(html"Welcome!"),
            p(html"Feel free to look around using the nav bar at the top! :3")
        ),
        section(
           h2(html"HzgShowAround"),
           p(html("🇩🇪 Für HzgShowAround, klicke einfach auf " & $a("/HzgShowAround/index.html", "diesen Hyperlink") & "!")).setLang("de"),
           p(html("🇬🇧 If you are here for HzgShowAround, just click " & $a("/HzgShowAround/index.html", "this hyperlink") & "!")).setLang("en"),
        )
    )
)

incl html
