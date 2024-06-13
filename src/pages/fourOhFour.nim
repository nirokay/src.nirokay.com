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
        h1("404: Not found"),
        p("The page you requested does not exist :/")
    )
)

incl html
