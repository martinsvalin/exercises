module Hamming exposing (distance)

import List exposing (filter, length, map2)
import Result exposing (Result(..))
import String exposing (toList)


distance : String -> String -> Result String Int
distance left right =
    let
        a =
            toList left

        b =
            toList right
    in
    if length a == length b then
        map2 (==) a b |> filter (not << identity) |> length |> Ok

    else
        Err "left and right strands must be of equal length"
