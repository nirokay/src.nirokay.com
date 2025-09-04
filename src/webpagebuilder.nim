import generator except cattag
import cattag

# Import pages and css:
import pages/[
    index,
    links,
    projects,
    games,
    fourOhFour
]
export
    index,
    links,
    projects,
    games,
    fourOhFour

import css/[
    styles
]
export
    styles

proc `/`[T](current: int, sequence: openArray[T]): string =
    result = $(current + 1) & "/" & $sequence.len()

if htmlPages.len() != 0:
    for i, page in htmlPages:
        stdout.write("\rGenerating '" & page.file & "' (" & i / htmlPages & ")                   ")
        stdout.flushFile()
        page.generatePage()
    stdout.write("\rGenerated " & $htmlPages.len() & " html files                              \n")
    stdout.flushFile()

if cssSheets.len() != 0:
    for i, sheet in cssSheets:
        stdout.write("\rGenerating '" & sheet.file & "' (" & i / cssSheets & ")                  ")
        sheet.generateCss()
    stdout.write("\rGenerated " & $cssSheets.len() & " css files                               \n")
    stdout.flushFile()
