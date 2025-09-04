import std/[strutils]
import ../generator, ../resources
import ../css/styles

var html: HtmlDocument = newHtmlPage(
    "Links",
    "Social Media links and other ways to engage with me.",
    "links.html"
)

html.add(
    header(
        h1(html"Links"),
        p(html"Links to all my socials.")
    )
)

proc email(reason: string, emailSuffix: string = "", generateSuffix: bool = true): HtmlElement =
    let
        suffix: string =
            if emailSuffix == "": reason.strip().toLower()
            else: emailSuffix
        email: string =
            if generateSuffix: "nirokay-public+" & suffix & "@protonmail.com?subject=[nirokay.com -> " & reason & "] Your subject here..."
            else: "nirokay-public@protonmail.com"
    result = tr(
        td(html reason),
        td(html a("mailto:" & email, email.split("?")[0]))
    )

proc newLink(name, img, url: string): HtmlElement =
    a(
        url,
        $img(pathImagesLinks & "/" & img, "Link to " & name).setClass(classClickableImage)
    ).addattr("target", "_blank").setTitle("Link to my " & name)
var links: seq[HtmlElement]
for link in linksToSocials:
    links.add newLink(link.name, link.img, link.url)

html.add(
    article(
        `div`(links).setClass(classFlexContainer).setStyle(
            margin := "25px 0px"
        ),
        `div`(
            table(
                thead(
                    tr(
                        th(html"Contact reason"),
                        th(html"Contact E-Mail or Webpage")
                    ),
                ),
                tbody(
                    tr(
                        td(html"Bug Fixes / Website issues"),
                        td(a("https://github.com/nirokay/src.nirokay.com/issues", "GitHub Repository"))
                    ),
                    email("Legal"),
                    email("Other", generateSuffix = false)
                ),
            ).setStyle(margin := "auto")
        )
    )
)

incl html
