import std/[tables, times, strutils]
import websitegenerator
export websitegenerator except newHtmlDocument, newDocument, writeFile
import resources

proc timeStamp(): string =
    result = now().format("yyyy-MM-dd ---- hh---mm--ss")
        .replace("----", "@")
        .replace("---", ":")
        .replace("--", ".")

var
    menuBarPages*: OrderedTable[string, string]
    htmlPages*: seq[HtmlDocument] ## Global variable for all html pages to be generated
    cssSheets*: seq[CssStyleSheet] ## Global variable for all css stylesheets to be generated


proc incl*(html: HtmlDocument) = htmlPages.add html ## Includes an HTML page into `htmlPages`
proc incl*(css: CssStyleSheet) = cssSheets.add css ## Includes a CSS stylesheet into `cssSheets`

proc newHtmlPage*(title, description, path: string, includeInMenuBar: bool = true, cssPath: string = ""): HtmlDocument =
    result = newHtmlDocument(path)
    # Html header stuff:
    result.addToHead(
        htmlComment("HTML and CSS is generated using https://github.com/nirokay/websitegenerator"),
        htmlComment("Generated: " & timeStamp()),
        charset("utf-8"),
        "meta"[
            "name" -= "viewport",
            "content" -= "width=device-width, initial-scale=1"
        ],
        title(title),
        ogTitle(title),
        description(description),
        ogDescription(description),
        icon(pathImages & "/favicon.gif", imageGif, "32x32"),
        "link"[
            "rel" -= "stylesheet",
            "href" -= "/styles.css",
            "title" -= "Absolute path to global css"
        ],
        importScript("/javascript/menu-bar.js")
    )
    if includeInMenuBar: menuBarPages[title] = path

    # Site-specific stylesheet:
    if cssPath != "":
        result.addToHead(
            "link"[
                "rel" -= "stylesheet",
                "href" -= "/" & cssPath
            ]
        )

proc getNavSelector(page: HtmlDocument): HtmlElement =
    var
        itemWasSelected: bool = false
        options: seq[HtmlElement] = @[
            option("--ignore--", "🚀 Navigation"),
            option("HzgShowAround/index.html", "🔍 HzgShowAround")
        ]
    for title, path in menuBarPages:
        var newOption: HtmlElement = option(path, title)
        #[
        if path == page.file:
            newOption.addattr("selected")
            itemWasSelected = true
        ]#
        options.add newOption
    if not itemWasSelected:
        options[0].addattr("selected")
    result = select("Menu bar", "id-menu-bar", options).add(
        attr("onchange", "changeToSelectedPage();"),
        attr("onfocus", "setSelectedToNavigation();"),
        attr("id", "id-menu-bar")
    )

proc getTopBar(html: HtmlDocument): HtmlElement =
    proc newElem(href, text: string): HtmlElement =
        a(href, text).addStyle(
            "color" := "#e8e6e3",
            "justify-self" := "flex-start"
        )
    var items: seq[HtmlElement] = @[
        newElem("/", "nirokay.com")
    ]
    let pathComponents: seq[string] = html.file.split("/")
    if pathComponents.len() != 0:
        var subUrl: string = pathComponents[0].split(".")[0]
        if subUrl notin ["index"]:
            if subUrl == "game": subUrl = "games"
            items.add newElem("/" & subUrl & ".html", subUrl.capitalizeAscii())

    var finalItems: seq[HtmlElement]
    for i, item in items:
        finalItems.add item
        if i < items.len() - 1: finalItems.add <$>" › "

    result = `div`(
        nav(h2(finalItems)).setClass("flex-container").addStyle("display" := "flex"),
        html.getNavSelector().addStyle("justify-self" := "flex-end")
    ).setClass("div-menu-bar-container").setClass("flex-container")

proc generatePage*(page: HtmlDocument) =
    ## Alternative for `writeFile(html)`, adding some final touches before generating the document
    var html: HtmlDocument = page
    html.body = @[
        `div`(
            `div`(
                `div`(page.body).setClass("div-centering-inner")
            ).setClass("div-centering-middle")
        ).setClass("div-centering-outer"),
        html.getTopBar()
    ]
    html.writeFile()

proc generateCss*(stylesheet: CssStyleSheet) =
    ## Alternative for `writeFile(css)`, adding some final touches before generating the stylesheet
    var css: CssStyleSheet = newCssStyleSheet(stylesheet.file)
    css.add cssComment(@[
        "@name nirokay.com stylesheet",
        "@author nirokay",
        "@source https://github.com/nirokay/src.nirokay.com",
        "@website https://nirokay.com",
        "HTML and CSS is generated using https://github.com/nirokay/websitegenerator",
        "Generated at " & timeStamp()
    ])
    css.elements = css.elements & stylesheet.elements
    css.writeFile()
