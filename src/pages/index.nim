import ../generator

var html: HtmlDocument = newHtmlPage(
    "Home",
    "Welcome to my little homepage!",
    "index.html"
)

html.add(
    header(
        h1("Welcome to nirokay.com"),
        p("This is still a placeholder, something cool will pop up here soon, trust me!")
    )
)

incl html
