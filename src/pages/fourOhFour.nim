import std/[]
import ../generator

var html: HtmlDocument = newHtmlPage(
    "404",
    "The page you requested does not exist...",
    "404.html",
    false
)

html.add(
    header(
        h1(html "404: Not found"),
        p(html "The page you requested does not exist :/")
    )
)

incl html
