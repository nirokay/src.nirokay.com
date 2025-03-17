import ../generator

const
    # Backgrounds:
    colourBackgroundDark* = rgb(23, 25, 33) # Stolen from Nim doc generator with love <3
    colourBackgroundMiddle* = "#23252c"
    colourBackgroundLight* = "#2f3139"

    colourBackgroundTransparentDarken* = "#14151C" # rgba(0, 0, 0, 0.15)
    colourBackgroundTransparentLighten* = "#1E2028" # rgba(255, 255, 255, 0.03)

    colourButton* = colourBackgroundLight #rgba(255, 100, 255, 0.1)
    colourButtonHover* = colourBackgroundMiddle #rgba(255, 100, 255, 0.2)
    colourButtonClick* = colourBackgroundDark

    # Palette:
    colourPalettePrimary* = HotPink ## Vibrant colour
    colourPaletteSecondary* = MistyRose ## Less vibrant colour
    colourPaletteTrinary* = LightPink ## Almost white colour

    # Text:
    colourText* = "#e8e6e3" # Stolen from DarkReader with love <3
    colourTextGrey* = "#979592"

    colourLinkDefault* = colourPalettePrimary
    colourLinkVisited* = colourLinkDefault
    colourLinkHover* = colourPaletteTrinary
    colourLinkClick* = colourPaletteSecondary

    # Progress bars:
    colourProgressBarForeground* = colourText
    colourProgressBarBackground* = colourPalettePrimary

    # Rainbow:
    colourMagenta* = "#F46ECE"
    colourRed* = "#F4716E"
    colourOrange* = "#F4956E"
    colourYellow* = "#F4E96E"
    colourGreen* = "#8BF46E"
    colourTurquoise* = "#6EF4D0"
    colourLightBlue* = "#6EADF4"
    colourBlue* = "#776EF4"
    colourPurple* = "#C36EF4"

    coloursGradientRainbow*: seq[string] = @[
        colourMagenta,
        colourRed,
        colourOrange,
        colourYellow,
        colourGreen,
        colourTurquoise,
        colourLightBlue,
        colourBlue,
        colourPurple
    ]
    #[ Old colours:
    @[
        rgb(225, 53, 53),
        rgb(229, 161, 60),
        rgb(216, 228, 59),
        rgb(80, 204, 223),
        rgb(70, 141, 222),
        rgb(139, 86, 245),
        rgb(192, 62, 239),
        rgb(214, 61, 194)
    ]
    ]#


