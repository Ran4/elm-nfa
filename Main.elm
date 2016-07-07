module Main exposing (..)

import Html exposing (Html)
import Html.App as App
import Html.Events


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type Q
    = On
    | Off


type Σ
    = TurnOn
    | TurnOff



-- Translation function


trans : Σ -> Q -> Q
trans input q =
    case ( input, q ) of
        ( TurnOn, _ ) ->
            On

        ( TurnOff, _ ) ->
            Off



-- Initial state


q0 : Q
q0 =
    Off


f : List Q
f =
    [ On ]


inFinalState : Q -> List Q -> Bool
inFinalState q f =
    List.member q f


type alias Model =
    Q


init : ( Model, Cmd Msg )
init =
    ( q0, Cmd.none )


getStateRepr : Q -> String
getStateRepr state =
    case state of
        On ->
            "On"

        Off ->
            "Off"


getInputRepr : Σ -> String
getInputRepr input =
    case input of
        TurnOn ->
            "TurnOn"

        TurnOff ->
            "TurnOff"



-- UPDATE


type Msg
    = SendInput Σ


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendInput input ->
            ( trans input model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW
-- createButton : Σ -> Html a


createButton : Σ -> Html Msg
createButton input =
    Html.button [ Html.Events.onClick <| SendInput input ] [ Html.text <| getInputRepr input ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.text <| "State: " ++ getStateRepr model
        , Html.text
            <| if inFinalState model f then
                " (Final state!)"
               else
                ""
        , Html.br [] []
        , Html.text "Inputs: "
        , createButton TurnOn
        , createButton TurnOff
        ]
