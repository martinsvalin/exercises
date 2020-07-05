module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )

import Parser exposing (Parser, Step(..), end, loop, map, oneOf, symbol)



-- TYPES


type Bearing
    = North
    | East
    | South
    | West


type alias Robot =
    { bearing : Bearing
    , coordinates : ( Int, Int )
    }


type alias Instructions =
    List (Robot -> Robot)



-- PUBLIC


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = ( 0, 0 )
    }


turnRight : Robot -> Robot
turnRight robot =
    case robot.bearing of
        North ->
            { robot | bearing = East }

        East ->
            { robot | bearing = South }

        South ->
            { robot | bearing = West }

        West ->
            { robot | bearing = North }


turnLeft : Robot -> Robot
turnLeft robot =
    case robot.bearing of
        North ->
            { robot | bearing = West }

        East ->
            { robot | bearing = North }

        South ->
            { robot | bearing = East }

        West ->
            { robot | bearing = South }


advance : Robot -> Robot
advance robot =
    let
        ( x, y ) =
            robot.coordinates
    in
    case robot.bearing of
        North ->
            { robot | coordinates = ( x, y + 1 ) }

        East ->
            { robot | coordinates = ( x + 1, y ) }

        South ->
            { robot | coordinates = ( x, y - 1 ) }

        West ->
            { robot | coordinates = ( x - 1, y ) }


simulate : String -> Robot -> Robot
simulate directions robot =
    directions |> parse |> List.foldr identity robot



-- PRIVATE


parse : String -> Instructions
parse input =
    case Parser.run (loop [] direction) input of
        Err _ ->
            []

        Ok instructions ->
            instructions


direction : Instructions -> Parser (Step Instructions Instructions)
direction acc =
    oneOf
        [ symbol "L" |> map (\() -> Loop (turnLeft :: acc))
        , symbol "R" |> map (\() -> Loop (turnRight :: acc))
        , symbol "A" |> map (\() -> Loop (advance :: acc))
        , end |> map (\() -> Done acc)
        ]
