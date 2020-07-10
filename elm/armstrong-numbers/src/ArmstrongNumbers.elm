module ArmstrongNumbers exposing (isArmstrongNumber)


isArmstrongNumber : Int -> Bool
isArmstrongNumber number =
    number == armstrong number


armstrong : Int -> Int
armstrong number =
    let
        digits =
            toDigits [] number

        power =
            List.length digits
    in
    List.foldl (\digit sum -> sum + digit ^ power) 0 digits


toDigits : List Int -> Int -> List Int
toDigits acc num =
    case num // 10 of
        0 ->
            remainderBy 10 num :: acc

        rest ->
            toDigits (remainderBy 10 num :: acc) rest
