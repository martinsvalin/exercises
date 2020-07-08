module Transpose exposing (transpose)

import List exposing (head, isEmpty, map, reverse, tail)
import List.Extra exposing (dropWhile)


transpose : List String -> List String
transpose lines =
    lines
        |> map String.toList
        |> transp
        |> map (trimRight >> map (Maybe.withDefault ' ') >> String.fromList)


transp : List (List Char) -> List (List (Maybe Char))
transp matrix =
    if List.all isEmpty matrix then
        []

    else
        map head matrix :: transp (map (tail >> Maybe.withDefault []) matrix)


trimRight : List (Maybe Char) -> List (Maybe Char)
trimRight list =
    list |> reverse |> dropWhile ((==) Nothing) |> reverse
