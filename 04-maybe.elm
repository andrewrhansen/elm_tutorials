module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { celsiusInput : String
    , farenInput : String
    , metersInput : String
    , inchesInput : String
    }


init : Model
init =
    Model "" "" "" ""



-- UPDATE


type Msg
    = CelsiusInput String
    | FarenInput String
    | MetersInput String
    | InchesInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        CelsiusInput celsiusInput ->
            { model | celsiusInput = celsiusInput }

        FarenInput farenInput ->
            { model | farenInput = farenInput }

        MetersInput metersInput ->
            { model | metersInput = metersInput }

        InchesInput inchesInput ->
            { model | inchesInput = inchesInput }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Conversions Example Using Maybes" ]
        , div [] [ convertToFaren model ]
        , div [] [ convertToCelsius model ]
        , div [] [ convertToInches model ]
        , div [] [ convertToMeters model ]
        ]


convertToFaren : Model -> Html Msg
convertToFaren model =
    case String.toFloat model.celsiusInput of
        Just answer ->
            span []
                [ input [ value model.celsiusInput, onInput CelsiusInput, style "width" "40px", style "borderColor" "blue" ] []
                , text "°C = "
                , span [ style "color" "blue" ] [ String.fromFloat ((answer * 1.8) + 32) |> text ]
                , text "°F"
                ]

        Nothing ->
            span []
                [ input [ value model.celsiusInput, onInput CelsiusInput, style "width" "40px", style "borderColor" "red" ] []
                , text "°C = "
                , span [ style "color" "red" ] [ text "???" ]
                , text "°F"
                ]


convertToCelsius : Model -> Html Msg
convertToCelsius model =
    case String.toFloat model.farenInput of
        Just answer ->
            span []
                [ input [ value model.farenInput, onInput FarenInput, style "width" "40px", style "borderColor" "blue" ] []
                , text "°F = "
                , span [ style "color" "blue" ] [ String.fromFloat ((answer - 32) / 1.8) |> text ]
                , text "°C"
                ]

        Nothing ->
            span []
                [ input [ value model.farenInput, onInput FarenInput, style "width" "40px", style "borderColor" "red" ] []
                , text "°F = "
                , span [ style "color" "red" ] [ text "???" ]
                , text "°C"
                ]


convertToInches : Model -> Html Msg
convertToInches model =
    case String.toFloat model.metersInput of
        Just answer ->
            span []
                [ input [ value model.metersInput, onInput MetersInput, style "width" "40px", style "borderColor" "blue" ] []
                , text " Meters = "
                , span [ style "color" "blue" ] [ String.fromFloat (answer * 39.37) |> text ]
                , text " Inches"
                ]

        Nothing ->
            span []
                [ input [ value model.metersInput, onInput MetersInput, style "width" "40px", style "borderColor" "red" ] []
                , text " Meters = "
                , span [ style "color" "red" ] [ text "???" ]
                , text " Inches"
                ]


convertToMeters : Model -> Html Msg
convertToMeters model =
    case String.toFloat model.inchesInput of
        Just answer ->
            span []
                [ input [ value model.inchesInput, onInput InchesInput, style "width" "40px", style "borderColor" "blue" ] []
                , text " Inches = "
                , span [ style "color" "blue" ] [ String.fromFloat (answer / 39.37) |> text ]
                , text " Meters"
                ]

        Nothing ->
            span []
                [ input [ value model.inchesInput, onInput InchesInput, style "width" "40px", style "borderColor" "red" ] []
                , text " Inches = "
                , span [ style "color" "red" ] [ text "???" ]
                , text " Meters"
                ]
