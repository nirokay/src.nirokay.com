import ../generator

const
    # Backgrounds:
    colourBackgroundDark* = rgb(23, 25, 33) # Stolen from Nim doc generator with love <3
    colourBackgroundMiddle* = "#23252c"
    colourBackgroundLight* = "#2f3139"

    # colourContentBox* = "#23252c" ## `colourContentBox` over `colourBackground`
    # colourContentBoxTransparent* = rgba(255, 255, 255, 0.05) ## white transparency, old form of `colourContentBox`

    colourButton* = rgba(255, 100, 255, 0.1)
    colourButtonHover* = rgba(255, 100, 255, 0.2)

    # Palette:
    colourPalettePrimary* = HotPink ## Vibrant colour
    colourPaletteSecondary* = MistyRose ## Less vibrant colour
    colourPaletteTrinary* = LightPink ## Almost white colour

    # Text:
    colourText* = "#e8e6e3" # Stolen from DarkReader with love <3

    colourLinkDefault* = colourPalettePrimary
    colourLinkVisited* = colourLinkDefault
    colourLinkHover* = colourPaletteTrinary
    colourLinkClick* = colourPaletteSecondary

    # Progress bars:
    colourProgressBarForeground* = colourText
    colourProgressBarBackground* = colourPalettePrimary

