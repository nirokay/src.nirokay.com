import generator

proc pc*(text: string): HtmlElement = p(text).addStyle("text-align" := "center")
proc pc*(text: seq[string]): HtmlElement = p(text).addStyle("text-align" := "center")
proc pc*(text: varargs[string]): HtmlElement = p(text).addStyle("text-align" := "center")
proc pc*(children: seq[HtmlElement]): HtmlElement = p(children).addStyle("text-align" := "center")
proc pc*(children: varargs[HtmlElement]): HtmlElement = p(children).addStyle("text-align" := "center")
