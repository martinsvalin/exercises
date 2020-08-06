module LargestSeriesProduct exposing (largestProduct)

import Char exposing (isDigit, toCode)
import List exposing (map, maximum, product)
import List.Extra exposing (groupsOfWithStep)
import Maybe exposing (withDefault)


{-| Find the larges product from adjacent numbers of the given length within the series. Length must be zero up to series length.

    largestProduct 2 "0123456789" -- Just 72

    largestProduct -1 "0123456789" -- Nothing

    largestProduct 5 "123" -- Nothing

    largestProduct 0 "" -- 1

-}
largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    if validInput length series then
        Just (calculate length series)

    else
        Nothing


{-| Validate input: Length must zero up to series length, inclusive, and series must be only digits.
-}
validInput : Int -> String -> Bool
validInput length series =
    0 <= length && length <= String.length series && String.all isDigit series


{-| Given a string of digits, calculate the largest product of a group of adjacent numbers of given length
-}
calculate : Int -> String -> Int
calculate length =
    toDigits
        >> groupsOfWithStep length 1
        >> map product
        >> maximum
        >> withDefault 1


{-| Convert a string consisting of digits 0-9 to a corresponding list of integers

    toDigits "12345" -- [1,2,3,4,5]

-}
toDigits : String -> List Int
toDigits =
    String.toList >> map (\char -> toCode char - toCode '0')
