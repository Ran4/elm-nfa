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


trans : Σ -> Q -> Q
trans input q =
    case ( input, q ) of
        ( TurnOn, _ ) ->
            On

        ( TurnOff, _ ) ->
            Off


inFinalState : Q -> List Q -> Bool
inFinalState q finalStates =
    List.member q finalStates


finalStates : List Q
finalStates =
    [ On ]



-- Initial state


type alias Model =
    Q


q0 : Q
q0 =
    Off


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


createButton : Σ -> Html Msg
createButton input =
    Html.button [ Html.Events.onClick <| SendInput input ]
        [ Html.text <| getInputRepr input ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.text <| "State: " ++ getStateRepr model
        , Html.text
            <| if inFinalState model finalStates then
                " (Final state!)"
               else
                ""
        , Html.br [] []
        , Html.text "Inputs: "
        , createButton TurnOn
        , createButton TurnOff
        ]
