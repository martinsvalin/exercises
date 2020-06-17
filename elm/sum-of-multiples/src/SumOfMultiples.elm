module SumOfMultiples exposing (sumOfMultiples)

import List exposing (concat, map, sum)
import List.Extra exposing (unique)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples divisors limit =
    map (multiplesUpTo limit) divisors
        |> concat
        |> unique
        |> sum


multiplesUpTo : Int -> Int -> List Int
multiplesUpTo limit number =
    multiplesUpToHelper [] limit number number


multiplesUpToHelper : List Int -> Int -> Int -> Int -> List Int
multiplesUpToHelper acc limit number sumSoFar =
    if sumSoFar < limit then
        multiplesUpToHelper (sumSoFar :: acc) limit number (sumSoFar + number)

    else
        acc
