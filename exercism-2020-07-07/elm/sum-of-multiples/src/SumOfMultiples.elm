module SumOfMultiples exposing (sumOfMultiples)

import List exposing (concat, map, sum)
import List.Extra exposing (unfoldr, unique)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples divisors limit =
    divisors
        |> map (multiplesUpTo limit)
        |> concat
        |> unique
        |> sum


multiplesUpTo : Int -> Int -> List Int
multiplesUpTo limit number =
    unfoldr (nextMultipleUpTo limit) ( number, number )


{-|

    Unfoldr can be a bit mind-bending. Here's what's happening:
    On each iteration, if the condition holds, we return Just (thingToEmit, nextValue), so this will
    emit `sumSoFar` as long as it's less than the limit.
    The value we iterate on is a tuple so that we keep both the current sum and the original number.
    Unfoldr will stop at Nothing. ;-)

-}
nextMultipleUpTo : Int -> ( Int, Int ) -> Maybe ( Int, ( Int, Int ) )
nextMultipleUpTo limit ( sumSoFar, number ) =
    if sumSoFar < limit then
        Just ( sumSoFar, ( sumSoFar + number, number ) )

    else
        Nothing
