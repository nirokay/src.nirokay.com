import std/[tables, times, strutils]
import cattag
export cattag except newHtmlDocument, newDocument, writeFile
import resources, snippets, css/[colours, classes]
import css/globals except newCssStyleSheet
export snippets

proc join*(elements: seq[HtmlElement], sep: HtmlElement): seq[HtmlElement] =
    ## Joins `HtmlElement`s by an `HtmlElement` as separator
    result = @[]
    for i, element in elements:
        result.add element
        if i == elements.len() - 1: break
        result.add sep

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
        newHtmlComment("HTML and CSS is generated using https://github.com/nirokay/websitegenerator"),
        newHtmlElement("meta", @[charset <=> "utf-8"]),
        newHtmlElement("meta", @[
            "name" <=> "viewport",
            "content" <=> "width=device-width, initial-scale=1"
        ]),
        title(html title),
        newHtmlElement("meta", @["property" <=> "og:title", "content" <=> title]),
        newHtmlElement("meta", @["property" <=> "description", "content" <=> description]),
        newHtmlElement("meta", @["property" <=> "og:description", "content" <=> description]),
        newHtmlElement("meta", @["property" <=> "", "content" <=> ""]),
        link(@[
            href <=> pathImages & "/favicon.gif",
            sizes <=> "32x32",
            `type` <=> "image/gif"
        ]),
        link(@[
            rel <=> "stylesheet",
            href <=> "/styles.css",
            title <=> "Absolute path to global css"
        ]),
        script(true).setSrc("/javascript/menu-bar.js")
    )
    if includeInMenuBar: menuBarPages[title] = path

    # Site-specific stylesheet:
    if cssPath != "":
        result.addToHead(
            link(@[
                rel <=> "stylesheet",
                href <=> "/" & cssPath
            ])
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
        options[0].add(newAttribute("selected"))
    result = select("id-menu-bar", options).add(
        attr("onchange", "changeToSelectedPage();"),
        attr("onfocus", "setSelectedToNavigation();"),
        attr("id", "id-menu-bar")
    )

proc getTopBar(html: HtmlDocument): HtmlElement =
    proc newElem(href, text: string): HtmlElement =
        a(href, text).setStyle(
            color := colourText,
            justifySelf := "flex-start"
        )
    var items: seq[HtmlElement] = @[
        newElem("/", "nirokay.com")
    ]
    let pathComponents: seq[string] = html.file.split("/")
    if pathComponents.len() != 0:
        var subUrl: string = pathComponents[0].split(".")[0]
        if subUrl notin ["index", "404"]:
            if subUrl == "game": subUrl = "games"
            items.add newElem("/" & subUrl & ".html", subUrl.capitalizeAscii())

    result = `div`(
        nav(h2(items.join(html" › "))).setClass(classFlexContainer).setStyle(display := "flex"),
        html.getNavSelector().setStyle(justifySelf := "flex-end")
    ).setClass(classDivMenuBarContainer).setClass(classFlexContainer).setStyle(justifyContent := "flex-start")

proc generatePage*(page: HtmlDocument) =
    ## Alternative for `writeFile(html)`, adding some final touches before generating the document
    var html: HtmlDocument = page
    html.body = @[
        `div`(
            `div`(
                `div`(page.body).setClass(classDivCenteringInner)
            ).setClass(classDivCenteringMiddle)
        ).setClass(classDivCenteringOuter),
        html.getTopBar()
    ]
    html.writeFile()

proc generateCss*(stylesheet: CssStylesheet) =
    ## Alternative for `writeFile(css)`, adding some final touches before generating the stylesheet
    var css: CssStylesheet = newCssStylesheet(stylesheet.file)
    css.add newCssComment(@[
        "@name nirokay.com stylesheet",
        "@author nirokay",
        "@source https://github.com/nirokay/src.nirokay.com/",
        "@website https://nirokay.com/",
        "HTML and CSS is generated using https://github.com/nirokay/websitegenerator/",
        "Generated at " & timeStamp()
    ])
    css.children = css.children & stylesheet.children
    css.writeFile()
