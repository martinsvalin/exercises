module Leap exposing (isLeapYear)


isLeapYear : Int -> Bool
isLeapYear year =
    every 4 year
        && not (every 100 year)
        || every 400 year


every : Int -> Int -> Bool
every period year =
    modBy period year == 0
