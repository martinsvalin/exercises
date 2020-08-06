module Grains exposing (square, total)

import BigInt exposing (add, fromInt, pow, toString)


square : Int -> Maybe Int
square n =
    if n > 0 && n < 64 then
        Just (2 ^ (n - 1))

    else
        Nothing


total : String
total =
    pow (fromInt 2) (fromInt 64)
        |> add (fromInt -1)
        |> toString
