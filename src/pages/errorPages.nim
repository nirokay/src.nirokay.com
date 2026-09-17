import std/[]
import ../generator

proc newErrorPage(code: int, short, long: string): HtmlDocument =
    result = newHtmlPage(
        $code,
        long,
        $code & ".html",
        false
    )
    result.add(
        header(
            h1(html $code & ": " & short),
            p(html long)
        )
    )

incl newErrorPage(
    404,
    "Not found",
    "The page you requested does not exist..."
)
incl newErrorPage(
    403,
    "Forbidden",
    "You cannot access this, why are you snooping around?"
)
