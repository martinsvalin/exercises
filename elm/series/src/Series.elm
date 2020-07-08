module Series exposing (slices)

import Char exposing (isDigit)
import List.Extra exposing (groupsOfWithStep)
import Result exposing (Result(..))


slices : Int -> String -> Result String (List (List Int))
slices size input =
    if size == 0 then
        Err "slice length cannot be zero"

    else if size < 0 then
        Err "slice length cannot be negative"

    else if input == "" then
        Err "series cannot be empty"

    else if String.length input < size then
        Err "slice length cannot be greater than series length"

    else if input /= String.filter isDigit input then
        Err "series must be digits only"

    else
        Ok (groupsOfWithStep size 1 (toDigits input))


toDigits : String -> List Int
toDigits =
    String.toList >> List.map (\c -> Char.toCode c - Char.toCode '0')
