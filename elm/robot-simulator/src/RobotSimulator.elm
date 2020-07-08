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
    , coordinates : Coordinates
    }


type alias Coordinates =
    { x : Int
    , y : Int
    }


type alias Directions =
    List (Robot -> Robot)



-- PUBLIC


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
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
        coord =
            robot.coordinates
    in
    { robot
        | coordinates =
            case robot.bearing of
                North ->
                    { coord | y = coord.y + 1 }

                East ->
                    { coord | x = coord.x + 1 }

                South ->
                    { coord | y = coord.y - 1 }

                West ->
                    { coord | x = coord.x - 1 }
    }


simulate : String -> Robot -> Robot
simulate directions robot =
    directions |> parse |> List.foldr identity robot



-- PARSING


parse : String -> Directions
parse input =
    case Parser.run (loop [] direction) input of
        Err _ ->
            []

        Ok directions ->
            directions


direction : Directions -> Parser (Step Directions Directions)
direction acc =
    oneOf
        [ symbol "L" |> map (\() -> Loop (turnLeft :: acc))
        , symbol "R" |> map (\() -> Loop (turnRight :: acc))
        , symbol "A" |> map (\() -> Loop (advance :: acc))
        , end |> map (\() -> Done acc)
        ]
