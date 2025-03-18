import std/[json, tables, options]
import pages/types

type ResourceFile* = enum
    resourceLinks = "resources/links.json",
    resourceProjects = "resources/projects.json",
    resourceGames = "resources/games.json",
    resourceGameWhoSaidWhat = "resources/game/who-said-what.json"

proc parseResource[T](resource: ResourceFile, convertTo: typedesc[T]): T =
    let file: string = $resource
    var fileContent: string
    try:
        fileContent = readFile(file)
    except IOError:
        echo "File '" & file & "' could not be read..."
        quit QuitFailure

    var node: JsonNode
    try:
        node = fileContent.parseJson()
    except JsonParsingError as e:
        echo "JSON file '" & file & "' could not be parsed... " & e.msg
        quit QuitFailure

    try:
        result = node.to(T)
    except CatchableError as e:
        echo "Could not convert '" & file & "' JSON to '" & $T & "'... " & e.msg
        quit QuitFailure

const
    # Directories: ------------------------------------------------------------
    pathResources*: string = "/resources/"
    pathImages*: string = pathResources & "images/"
    pathImagesLanguage*: string = pathImages & "language/"
    pathImagesLinks*: string = pathImages & "links/"


type
    ImageLink* = object
        name*, img*, url*: string

    ProjectElement* = object
        name*, desc*, repo*, lang*: string
        docs*: Option[string]

    Game* = object
        name*, desc*, title*: string
        universal*: Option[bool] = some(false)

    WhoSaidWhatAuthor* = object
        imageUrl*: Option[string] = some("unknown.svg")
        allegiances*: seq[string]
    WhoSaidWhatAuthors* = OrderedTable[string, WhoSaidWhatAuthor]
    WhoSaidWhatThesis* = object
        enGB*, deDE*, source*, author*: string

    WhoSaidWhatFileStructure* = object
        authors*: WhoSaidWhatAuthors
        thesis*: seq[WhoSaidWhatThesis]

const
    # JSONs: ------------------------------------------------------------------
    linksToSocials* = resourceLinks.parseResource(seq[ImageLink])
    projectShowcase* = resourceProjects.parseResource(OrderedTable[string, seq[ProjectElement]])
    gamesJson* = resourceGames.parseResource(seq[Game])
    whoSaidWhatJson* = resourceGameWhoSaidWhat.parseResource(WhoSaidWhatFileStructure)
