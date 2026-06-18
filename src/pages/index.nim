import ../generator, ../css/styles, ./types

var html: HtmlDocument = newHtmlPage(
    "Home",
    "Welcome to my little homepage!",
    "index.html"
)


proc pl(lang: Language, lines: varargs[string]): HtmlElement =
    let
        flag: string = case lang:
            of enGB: "🇬🇧"
            of deDE: "🇩🇪"
        langCode: string = case lang:
            of enGB: "en"
            of deDE: "de"

    var elements: seq[HtmlElement]
    for i, l in lines:
        let line: string = if i == 0: flag & " " & l else: l
        elements.add html line
        if i != lines.len() - 1: elements.add br()

    result = p(elements).setLang(langCode)

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
            p(
                html"Feel free to look around using ",
                u b html"the nav bar",
                html" at the top or use",
                u b html"the hyperlinked headings",
                html"below! :3"
            )
        ),
        section(
            h2(a("/HzgShowAround/index.html", "HzgShowAround")),
            pl(deDE, "Für HzgShowAround, klicke einfach auf die Überschrift darüber!"),
            pl(enGB, "If you are here for HzgShowAround, click the heading above!"),
        ),
        hr(),
        section(
            h2(a("/links.html", "Links")),
            pl(deDE, "Links zu aller meiner Social Media Accounts."),
            pl(enGB, "All my social media account links.")
        ),
        section(
            h2(a("/projects.html", "Projects")),
            pl(deDE, "Display meiner Projekte mit Links zu Quellcodes und Dokumentationen."),
            pl(enGB, "Showcase of my projects with links to sources and documentations.")
        ),
        section(
            h2(a("/games.html", "Games")),
            pl(deDE, "Silly Spiele spielbar im Browser."),
            pl(enGB, "Silly games playable in your browser.")
        )
    )
)

incl html
