import ../generator

const
    # Backgrounds:
    colourBackground* = rgb(23, 25, 33) # Stolen from Nim doc generator with love <3
    colourContentBox* = rgba(255, 255, 255, 0.05)

    colourButton* = rgba(255, 100, 255, 0.1)
    colourButtonHover* = rgba(255, 100, 255, 0.2)

    # Palette:
    colourPalettePrimary* = HotPink
    colourPaletteSecondary* = MistyRose
    colourPaletteTrinary* = LightPink

    # Text:
    colourText* = "#e8e6e3" # Stolen from DarkReader with love <3

    colourLinkDefault* = colourPalettePrimary
    colourLinkVisited* = colourLinkDefault
    colourLinkHover* = colourPaletteTrinary
    colourLinkClick* = colourPaletteSecondary

    # Progress bars:
    colourProgressBarForeground* = colourText
    colourProgressBarBackground* = colourPalettePrimary

