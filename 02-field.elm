module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Attribute, Html, div, h1, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "The magic text reverser!" ]
        , div [] [ text "To start, type your text here:" ]
        , input [ placeholder "", value model.content, onInput Change ] []
        , div [] [ text "And here is your text...in reverse!" ]
        , div [] [ text (String.reverse model.content) ]
        ]
