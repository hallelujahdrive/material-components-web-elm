module Material.Chip.Internal exposing (Icon(..), materialIcon, customIcon, iconToLeadingIconElt)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type Icon msg
    = MaterialIcon String
    | CustomIcon (List (Html msg))
    | Unset


materialIcon : Maybe String -> Icon msg
materialIcon icon =
    case icon of
        Just icon_ -> MaterialIcon icon_
        
        _ -> Unset

customIcon : Maybe (List (Html msg)) -> Icon msg
customIcon icon =
    case icon of
        Just icon_ -> CustomIcon icon_

        _ -> Unset


iconToLeadingIconElt : Icon msg -> Maybe (Html msg)
iconToLeadingIconElt icon =
    let
        attrs = [ class "mdc-chip__icon mdc-chip__icon--leading" ]
    in
    case icon of
        MaterialIcon iconName ->
            Just <|
                Html.i (class "material-icons" :: attrs)
                    [ text iconName ]
        
        CustomIcon elt ->
            Just <| Html.span attrs elt

        _ ->
            Nothing