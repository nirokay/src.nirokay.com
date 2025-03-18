import std/[tables]
export tables

type
    Language* = enum
        enGB, deDE
    LanguageString* = OrderedTable[Language, string]
    LanguageObject* = object
        flag*, short*, long*: string

proc newLanguage(flag, short, long: string): LanguageObject = LanguageObject(
    flag: flag,
    short: short,
    long: long
)
const languageObject*: OrderedTable[Language, LanguageObject] = toOrderedTable {
    enGB: newLanguage("🇬🇧", "en", "English"),
    deDE: newLanguage("🇩🇪", "de", "Deutsch (German)")
}
proc get*(language: Language): LanguageObject = languageObject[language]

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
    result = language.get().short
