module Material.IconButton exposing
    ( Config, config
    , setOnClick
    , setDisabled
    , setLabel
    , setAttributes
    , iconButton
    , custom
    )

{-| Icon buttons allow users to take actions, and make choices, with a single
tap.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Icon Button](#icon-button)
  - [Disabled Icon Button](#disabled-icon-button)
  - [Labeled Icon Button](#labeled-icon-button)


# Resources

  - [Demo: Icon buttons](https://aforemny.github.io/material-components-web-elm/#icon-button)
  - [Material Design Guidelines: Toggle buttons](https://material.io/go/design-buttons#toggle-button)
  - [MDC Web: Icon Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button#sass-mixins)


# Basic Usage

If you are looking for a button that has an icon as well as text, refer to
[Button](Material-Button).

    import Material.IconButton as IconButton

    type Msg
        = Clicked

    main =
        IconButton.iconButton
            (IconButton.config
                |> IconButton.setOnClick Clicked
            )
            "favorite"


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setDisabled
@docs setLabel
@docs setAttributes


# Icon Button

@docs iconButton


# Disabled Icon Button

To disable an icon button, use its `setDisabled` configuration option.
Disabled icon buttons cannot be interacted with and have no visual interaction
effect.

    IconButton.iconButton
        (IconButton.config
            |> IconButton.setDisabled True
        )
        "favorite"


# Labeled Icon Button

To set the HTML attribute `arial-label` of a icon button, use its `setLabel`
configuration option.

    IconButton.iconButton
        (IconButton.config
            |> setLabel "Add to favorites"
        )
        "favorite"


# Variant: Custom Icon Button

@docs custom

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Material.IconButton.Internal exposing (Config(..))


{-| Icon button configuration
-}
type alias Config msg =
    Material.IconButton.Internal.Config msg


{-| Default icon button configuration
-}
config : Config msg
config =
    Config
        { disabled = False
        , label = Nothing
        , additionalAttributes = []
        , onClick = Nothing
        }


{-| Mark an icon button as disabled
-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Set an icon button's `arial-label` HTML5 attribute
-}
setLabel : String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = Just label }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user clicks on an icon button
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Icon button view function
-}
iconButton : Config msg -> String -> Html msg
iconButton ((Config { additionalAttributes }) as config_) iconName =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , materialIconsCs
            , tabIndexProp
            , clickHandler config_
            ]
            ++ additionalAttributes
        )
        [ text iconName ]


{-| TODO
-}
custom : Config msg -> List (Html msg) -> Html msg
custom ((Config { additionalAttributes }) as config_) nodes =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , tabIndexProp
            , clickHandler config_
            ]
            ++ additionalAttributes
        )
        nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-icon-button")


materialIconsCs : Maybe (Html.Attribute msg)
materialIconsCs =
    Just (class "material-icons")


iconCs : Maybe (Html.Attribute msg)
iconCs =
    Just (class "mdc-icon-button__icon")


tabIndexProp : Maybe (Html.Attribute msg)
tabIndexProp =
    Just (Html.Attributes.tabindex 0)


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")


ariaLabelAttr : Config msg -> Maybe (Html.Attribute msg)
ariaLabelAttr (Config { label }) =
    Maybe.map (Html.Attributes.attribute "aria-label") label


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map Html.Events.onClick onClick
