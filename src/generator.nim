import websitegenerator
export websitegenerator except newHtmlDocument, newDocument, writeFile
import resources

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
        og("description", description),
        icon(pathImages & "/favicon.gif", imageGif, "32x32"),
        "link"[
            "rel" => "stylesheet",
            "href" => "/styles.css",
            "title" => "Absolute path to global css"
        ],
        "link"[
            "rel" => "stylesheet",
            "href" => "styles.css",
            "title" => "Relative path to global css" # Used for local debugging/test builds
        ]
    )

    if cssPath != "":
        result.addToHead(
            "link"[
                "rel" => "stylesheet",
                "href" => cssPath # Local stylesheet (will not work when testing out locally :/)
            ]
        )

proc generatePage*(page: HtmlDocument) =
    ## Alternative for `writeFile(html)`, adding some final touches before generating the document
    var html: HtmlDocument = page
    html.body = @[
        `div`(
            `div`(
                `div`(html.body).setClass(".div-centering-inner")
            ).setClass(".div-centering-middle")
        ).setClass(".div-centering-outer")
    ]
    html.writeFile()
