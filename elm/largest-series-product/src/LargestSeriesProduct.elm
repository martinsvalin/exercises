module LargestSeriesProduct exposing (largestProduct)

import Char exposing (isDigit)
import List exposing (map, maximum, product)
import List.Extra exposing (groupsOfWithStep)
import Maybe exposing (withDefault)
import Maybe.Extra exposing (combine)


{-| Find the larges product from adjacent numbers of the given length within the series. Length must be zero up to series length.

    largestProduct 2 "0123456789" -- Just 72

    largestProduct -1 "0123456789" -- Nothing

    largestProduct 5 "123" -- Nothing

    largestProduct 0 "" -- 1

-}
largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    if length < 0 || String.length series < length then
        Nothing

    else
        series
            |> toDigits
            |> Maybe.map
                (groupsOfWithStep length 1
                    >> map product
                    >> maximum
                    >> withDefault 1
                )


{-| Convert a string consisting of digits 0-9 to a corresponding list of integers

    toDigits "12345" -- Just [1,2,3,4,5]

    toDigits "123abc" -- Nothing

    toDigits "" -- Just []

-}
toDigits : String -> Maybe (List Int)
toDigits =
    let
        digitToInt char =
            if isDigit char then
                Just (Char.toCode char - Char.toCode '0')

            else
                Nothing
    in
    String.toList >> map digitToInt >> combine
