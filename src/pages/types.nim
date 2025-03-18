import std/[tables]

type
    Language* = enum
        enGB = "English",
        deDE = "German (Deutsch)"
    LanguageString* = Table[Language, string]

proc newLanguageString*(en, de: string): LanguageString =
    result[enGB] = en
    result[deDE] = de
proc lang*(en, de: string): LanguageString = newLanguageString(en, de)

var translationTarget: Language = enGB
proc setTranslationTarget*(language: Language) =
    ## Sets the target language
    translationTarget = language
proc getTranslationTarget*(): Language =
    ## Gets the target language
    result = translationTarget

proc `$$`(str: LanguageString): string =
    ## Standard stringification for object, for debugging purposes only
    result = $str

proc `$`*(str: LanguageString): string =
    ## Returns the field of `translationTarget` (settable with `setTranslationTarget(lang)`)
    if not str.hasKey(translationTarget):
        echo "Failed to translate language string '" & $$str & "'!"
        return ""
    return str[translationTarget]

proc toUrlRepr*(language: Language): string =
    ## Representation of language in URL
    case language:
    of enGB: "en"
    of deDE: "de"
