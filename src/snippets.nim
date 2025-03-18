import std/[options]
export options
import generator

proc isSet*[T](option: Option[T]): bool =
    var comparison: T
    if option.isSome():
        if option.get() != comparison:
            result = true

proc pc*(text: string): HtmlElement = p(text).addStyle("text-align" := "center")
proc pc*(text: seq[string]): HtmlElement = p(text).addStyle("text-align" := "center")
proc pc*(text: varargs[string]): HtmlElement = p(text).addStyle("text-align" := "center")
proc pc*(children: seq[HtmlElement]): HtmlElement = p(children).addStyle("text-align" := "center")
proc pc*(children: varargs[HtmlElement]): HtmlElement = p(children).addStyle("text-align" := "center")
