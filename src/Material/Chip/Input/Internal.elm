module Material.Chip.Input.Internal exposing (Chip(..), Config(..))

import Html
import Material.Chip.Internal exposing (Icon)


type Config msg
    = Config
        { leadingIcon : Icon msg
        , trailingIcon : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , onDelete : Maybe msg
        }


type Chip msg
    = Chip (Config msg) String
