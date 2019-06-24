--Added pictures of dice faces instead of text.  Added a second dice that rolls at the same time as the first.


module Main exposing (Model, Msg(..), getPicture, init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { dieFace1 : Int
    , dieFace2 : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1 1
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Int
    | NewFace2 Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Cmd.batch [ Random.generate NewFace (Random.int 1 6), Random.generate NewFace2 (Random.int 1 6) ]
            )

        NewFace newFace1 ->
            ( Model newFace1 model.dieFace1
            , Cmd.none
            )

        NewFace2 newFace2 ->
            ( Model newFace2 model.dieFace2
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "A Game of Dice" ]
        , br [] []
        , getPicture model.dieFace1
        , getPicture model.dieFace2
        , br [] []
        , button [ onClick Roll ] [ text "Roll" ]
        ]


getPicture : Int -> Html Msg
getPicture num =
    case num of
        1 ->
            img [ src "images/die_face_1_T.png", height 100, width 100 ] []

        2 ->
            img [ src "images/die_face_2_T.png", height 100, width 100 ] []

        3 ->
            img [ src "images/die_face_3_T.png", height 100, width 100 ] []

        4 ->
            img [ src "images/die_face_4_T.png", height 100, width 100 ] []

        5 ->
            img [ src "images/die_face_5_T.png", height 100, width 100 ] []

        6 ->
            img [ src "images/die_face_6_T.png", height 100, width 100 ] []

        _ ->
            div [] [ text "something has gone very wrong" ]
