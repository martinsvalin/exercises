module Triangle exposing (Triangle(..), triangleKind)

import Result exposing (andThen)
import Set


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    [ x, y, z ]
        |> checkLength
        |> andThen checkTriangleInequality
        |> andThen determineKind


checkLength : List number -> Result String (List number)
checkLength sides =
    if List.all ((<) 0) sides then
        Ok sides

    else
        Err "Invalid lengths"


checkTriangleInequality : List number -> Result String (List number)
checkTriangleInequality sides =
    if List.all (\side -> side * 2 < List.sum sides) sides then
        Ok sides

    else
        Err "Violates inequality"


determineKind : List number -> Result String Triangle
determineKind sides =
    case sides |> Set.fromList |> Set.size of
        1 ->
            Ok Equilateral

        2 ->
            Ok Isosceles

        _ ->
            Ok Scalene
