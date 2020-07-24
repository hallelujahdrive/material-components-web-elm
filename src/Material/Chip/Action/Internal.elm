module Material.Chip.Action.Internal exposing (Chip(..), Config(..))

import Html
import Material.Chip.Internal exposing (Icon)


type Config msg
    = Config
        { icon : Icon msg
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        }


type Chip msg
    = Chip (Config msg) String
