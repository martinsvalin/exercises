module CollatzConjecture exposing (collatz)

import Result exposing (Result(..))


collatz : Int -> Result String Int
collatz start =
    if start > 0 then
        Ok (countSteps 0 start)

    else
        Err "Only positive numbers are allowed"


countSteps : Int -> Int -> Int
countSteps steps number =
    if number == 1 then
        steps

    else if modBy 2 number == 0 then
        countSteps (steps + 1) (number // 2)

    else
        countSteps (steps + 1) (number * 3 + 1)
