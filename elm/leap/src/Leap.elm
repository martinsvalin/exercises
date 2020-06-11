module Leap exposing (isLeapYear)


isLeapYear : Int -> Bool
isLeapYear year =
    case (modBy 400 year, modBy 100 year, modBy 4 year) of
        (0, _, _) -> True
        (_, 0, _) -> False
        (_, _, 0) -> True
        (_, _, _) -> False
