import std/[options, sequtils]
export options
import generator

proc isSet*[T](option: Option[T]): bool =
    var comparison: T
    if option.isSome():
        if option.get() != comparison:
            result = true

proc pc*(text: string): HtmlElement = p(html text).setStyle(textAlign := "center")
proc pc*(text: seq[string]): HtmlElement = p(html text).setStyle(textAlign := "center")
proc pc*(text: varargs[string]): HtmlElement = p(html text).setStyle(textAlign := "center")
proc pc*(children: seq[HtmlElement]): HtmlElement = p(children).setStyle(textAlign := "center")
proc pc*(children: varargs[HtmlElement]): HtmlElement = p(children.toSeq()).setStyle(textAlign := "center")
