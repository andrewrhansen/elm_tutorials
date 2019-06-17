module Main exposing (Model, Msg(..), init, main, update, view, viewInput, viewValidation)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    }


init : Model
init =
    Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String



-- | Validate


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            { model | age = age }



--Validate ->
--    viewValidation model
-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Form Example" ]
        , viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewInput "age" "Age" model.age Age
        , viewValidation model

        --, button [ onClick Validate ] [ text "Submit" ]
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    div []
        [ passwordsCompare model
        , passwordLengthCheck model
        , passwordCriteriaCheck model
        , ageCheck model
        ]


passwordsCompare : Model -> Html msg
passwordsCompare model =
    if model.password == model.passwordAgain then
        div [ style "color" "green" ] [ text "Passwords match" ]

    else
        div [ style "color" "red" ] [ text "Passwords do not match!" ]


passwordLengthCheck : Model -> Html msg
passwordLengthCheck model =
    if String.length model.password > 8 then
        div [ style "color" "green" ] [ text "Password is longer than 8 characters" ]

    else
        div [ style "color" "red" ] [ text "Password should be longer than 8 characters" ]


passwordCriteriaCheck : Model -> Html msg
passwordCriteriaCheck model =
    if
        String.any Char.isDigit model.password
            && String.any Char.isUpper model.password
            && String.any Char.isLower model.password
    then
        div [ style "color" "green" ] [ text "Password contains numbers" ]

    else
        div [ style "color" "red" ] [ text "Password should contain at least one number and both lower and upper case letters" ]


ageCheck : Model -> Html msg
ageCheck model =
    if String.toInt model.age == Nothing then
        div [ style "color" "red" ] [ text "Age is not a number!" ]

    else
        div [ style "color" "green" ] [ text "Age is a number" ]
