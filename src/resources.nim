import std/[json, tables, options]

type ResourceFile* = enum
    resourceLinks = "resources/links.json",
    resourceProjects = "resources/projects.json"

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
    ImageLink* = tuple[name, img, url: string]

    ProjectElement* = tuple[name, desc, repo, lang: string, docs: Option[string]]

const
    # JSONs: ------------------------------------------------------------------
    linksToSocials* = resourceLinks.parseResource(seq[ImageLink])
    projectShowcase* = resourceProjects.parseResource(OrderedTable[string, seq[ProjectElement]])
