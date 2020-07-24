module Material.Chip.Filter.Internal exposing (Chip(..), Config(..))

import Html
import Material.Chip.Internal exposing (Icon)


type Config msg
    = Config
        { icon : Icon msg
        , selected : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        }


type Chip msg
    = Chip (Config msg) String
