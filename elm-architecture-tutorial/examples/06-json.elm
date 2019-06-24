--Refactored to have a field for the user to input the tag on the random gif api call instead of being hardcoded


module Main exposing (Model, Msg(..), getGif, gifDecoder, init, main, subscriptions, update, view, viewGif)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, string)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Status
    = Failure
    | Loading
    | Success String


type alias Model =
    { status : Status
    , inputTag : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { status = Loading, inputTag = "theoffice" }, getGif "theoffice" )



-- UPDATE


type Msg
    = MorePlease
    | GotGif (Result Http.Error String)
    | UpdateTag String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( { model | status = Loading }, getGif model.inputTag )

        GotGif result ->
            case result of
                Ok url ->
                    ( { model | status = Success url }, Cmd.none )

                Err _ ->
                    ( { model | status = Failure }, Cmd.none )

        UpdateTag inputTag ->
            ( { model | inputTag = inputTag }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Random Gif Retreiver" ]
        , viewGif model
        ]


viewGif : Model -> Html Msg
viewGif model =
    case model.status of
        Failure ->
            div []
                [ text "Type gif search term here: "
                , input [ onInput UpdateTag, value model.inputTag ] []
                , text "I could not load a random gif for some reason. "
                , button [ onClick MorePlease ] [ text "Try Again!" ]
                ]

        Loading ->
            text "Loading..."

        Success url ->
            div []
                [ text "Type gif search term here: "
                , input [ onInput UpdateTag, value model.inputTag ] []
                , button [ onClick MorePlease, style "display" "block" ] [ text "More Please!" ]
                , img [ src url ] []
                ]



-- HTTP


getGif : String -> Cmd Msg
getGif tag =
    Http.get
        { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ tag
        , expect = Http.expectJson GotGif gifDecoder
        }


gifDecoder : Decoder String
gifDecoder =
    field "data" (field "image_url" string)
