import ../generator

var html: HtmlDocument = newHtmlPage(
    "Home",
    "Welcome to my little homepage!",
    "index.html"
)

html.add(
    header(
        h1("nirokay.com"),
        p("Welcome to my little homepage!")
    ),
    article(
        
    )
)

incl html
