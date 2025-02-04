import std/[tables]

type
    Language* = enum
        enGB = "English",
        deDE = "German (Deutsch)"
    LanguageString* = Table[Language, string]

var translationTarget: Language = enGB
proc setTranslationTarget*(language: Language) =
    ## Sets the target language
    translationTarget = language

proc `$$`(str: LanguageString): string =
    ## Standard stringification for object, for debugging purposes only
    result = $str

proc `$`*(str: LanguageString): string =
    ## Returns the field of `translationTarget` (settable with `setTranslationTarget(lang)`)
    if not str.hasKey(translationTarget):
        echo "Failed to translate language string '" & $$str & "'!"
        return ""
    return str[translationTarget]
