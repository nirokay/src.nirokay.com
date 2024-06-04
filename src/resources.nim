import std/[json]

type ResourceFile* = enum
    resourceLinks = "resources/links.json"

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

    # Images: -----------------------------------------------------------------
    imageLanguages* = (
        lua: pathImagesLanguage & "lua.png",
        nim: pathImagesLanguage & "nim-png"
    )

type
    ImageLink* = tuple[name, img, url: string]

const
    # JSONs: ------------------------------------------------------------------
    linksToSocials* = resourceLinks.parseResource(seq[ImageLink])

#[
    imageLinks* = (
        discord: (
            img: pathImagesLinks & "discord-mark-white.svg",
            url: "https://discordapp.com/users/279697404259991552"
        ),
        cohost: (
            img: pathImagesLinks & "cohost.svg",
            url: "https://cohost.org/nirokay"
        ),
        github: (
            img: pathImagesLinks & "github.svg",
            url: "https://github.com/nirokay"
        )
    )
]#
