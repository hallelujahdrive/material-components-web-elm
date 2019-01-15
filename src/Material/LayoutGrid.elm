module Material.LayoutGrid exposing
    ( Device(..)
    , cell
    , inner
    , layoutGrid
    , span1
    , span10
    , span11
    , span12
    , span2
    , span3
    , span4
    , span5
    , span6
    , span7
    , span8
    , span9
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type Device
    = Desktop
    | Tablet
    | Phone


layoutGrid : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGrid attributes nodes =
    Html.node "mdc-layout-grid" (class "mdc-layout-grid" :: attributes) nodes


inner : List (Html.Attribute msg) -> List (Html msg) -> Html msg
inner attributes nodes =
    Html.div (class "mdc-layout-grid__inner" :: attributes) nodes


cell : List (Html.Attribute msg) -> List (Html msg) -> Html msg
cell attributes nodes =
    Html.div (class "mdc-layout-grid__cell" :: attributes) nodes


span : Int -> Html.Attribute msg
span n =
    class ("mdc-layout-grid--span-" ++ String.fromInt n)


span1 : Html.Attribute msg
span1 =
    span 1


span2 : Html.Attribute msg
span2 =
    span 2


span3 : Html.Attribute msg
span3 =
    span 3


span4 : Html.Attribute msg
span4 =
    span 4


span5 : Html.Attribute msg
span5 =
    span 5


span6 : Html.Attribute msg
span6 =
    span 6


span7 : Html.Attribute msg
span7 =
    span 7


span8 : Html.Attribute msg
span8 =
    span 8


span9 : Html.Attribute msg
span9 =
    span 9


span10 : Html.Attribute msg
span10 =
    span 10


span11 : Html.Attribute msg
span11 =
    span 11


span12 : Html.Attribute msg
span12 =
    span 12