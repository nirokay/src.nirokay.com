import ../generator

const
    # Backgrounds:
    colourBackgroundDark* = rgb(23, 25, 33) # Stolen from Nim doc generator with love <3
    colourBackgroundMiddle* = "#23252c"
    colourBackgroundLight* = "#2f3139"

    colourButton* = colourBackgroundLight #rgba(255, 100, 255, 0.1)
    colourButtonHover* = colourBackgroundMiddle #rgba(255, 100, 255, 0.2)
    colourButtonClick* = colourBackgroundDark

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

    # Rainbow:
    coloursGradientRainbow* = @[
        rgb(225, 53, 53),
        rgb(229, 161, 60),
        rgb(216, 228, 59),
        rgb(80, 204, 223),
        rgb(70, 141, 222),
        rgb(139, 86, 245),
        rgb(192, 62, 239),
        rgb(214, 61, 194)
    ]
    #[
        Old colours:
        rgba(255, 0, 0, 1.0),
        rgba(255, 154, 0, 1.0),
        rgba(208, 222, 33, 1.0),
        rgba(79, 220, 74, 1.0),
        rgba(63, 218, 216, 1.0),
        rgba(47, 201, 226, 1.0),
        rgba(28, 127, 238, 1.0),
        rgba(95, 21, 242, 1.0),
        rgba(186, 12, 248, 1.0),
        rgba(251, 7, 217, 1.0),
        rgba(255, 0, 0, 1.0)
    ]#

