import websitegenerator
export websitegenerator except newHtmlDocument, newDocument, writeFile

var
    htmlPages*: seq[HtmlDocument] ## Global variable for all html pages to be generated
    cssSheets*: seq[CssStyleSheet] ## Global variable for all css stylesheets to be generated

proc incl*(html: HtmlDocument) = htmlPages.add html ## Includes an HTML page into `htmlPages`
proc incl*(css: CssStyleSheet) = cssSheets.add css ## Includes a CSS stylesheet into `cssSheets`


proc og(property, content: string): HtmlElement =
    result = "meta"[
        "property" => "og:" & property,
        "content" => content
    ]

proc newHtmlPage*(title, description, path: string, cssPath: string = ""): HtmlDocument =
    result = newHtmlDocument(path)
    # Html header stuff:
    result.addToHead(
        comment("HTML and CSS is generated using https://github.com/nirokay/websitegenerator "),
        charset("utf-8"),
        "meta"[
            "name" => "viewport",
            "content" => "width=device-width, initial-scale=1"
        ],
        title(title),
        og("title", title),
        og("description", description)
    )

    # Css:
    var css: string = (
        if cssPath != "": cssPath
        else: "/styles.css"
    )
    if css == "": css = "/styles.css"
    result.addToHead(
        "link"[
            "rel" => "stylesheet",
            "href" => css
        ]
    )
