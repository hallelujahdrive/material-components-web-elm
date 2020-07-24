module Material.Chip.Choice.Internal exposing (Chip(..), Config(..))

import Html
import Material.Chip.Internal exposing (Icon)


type Config msg
    = Config
        { icon : Icon msg
        , additionalAttributes : List (Html.Attribute msg)
        }


type Chip a msg
    = Chip (Config msg) a
