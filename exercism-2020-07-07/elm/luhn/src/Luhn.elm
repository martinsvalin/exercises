module Luhn exposing (checksum, valid)

import Char exposing (isDigit, toCode)
import List exposing (all, indexedMap, length, map, reverse, sum)


valid : String -> Bool
valid input =
    let
        digits =
            input |> String.replace " " "" |> String.toList
    in
    length digits > 1 && all isDigit digits && modBy 10 (checksum digits) == 0


checksum : List Char -> Int
checksum digits =
    digits
        |> reverse
        |> map charToInt
        |> indexedMap luhnDouble
        |> sum


charToInt : Char -> Int
charToInt char =
    toCode char - toCode '0'


luhnDouble : Int -> Int -> Int
luhnDouble index number =
    if modBy 2 index == 1 && number < 9 then
        number * 2 |> modBy 9

    else
        number
