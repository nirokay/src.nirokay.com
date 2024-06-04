import ../generator, ../resources
import ../css/styles

var html: HtmlDocument = newHtmlPage(
    "Links",
    "Links to all my socials.",
    "links.html"
)

html.add(
    header(
        h1("Links"),
        p("Links to all my socials.")
    )
)

proc newLink(name, img, url: string): HtmlElement =
    a(
        url,
        $img(pathImagesLinks & "/" & img, "Link to " & name).setClass(classClickableImage)
    )
var links: seq[HtmlElement]
for link in linksToSocials:
    links.add newLink(link.name, link.img, link.url)

html.add(
    article(
        `div`(links).setClass(classContainerLinks)
    )
)

incl html
