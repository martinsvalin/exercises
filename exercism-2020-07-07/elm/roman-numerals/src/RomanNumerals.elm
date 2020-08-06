module RomanNumerals exposing (toRoman)


toRoman : Int -> String
toRoman decimal =
    if decimal >= 1000 then
        "M" ++ toRoman (decimal - 1000)

    else if decimal >= 900 then
        "CM" ++ toRoman (decimal - 900)

    else if decimal >= 500 then
        "D" ++ toRoman (decimal - 500)

    else if decimal >= 400 then
        "CD" ++ toRoman (decimal - 400)

    else if decimal >= 100 then
        "C" ++ toRoman (decimal - 100)

    else if decimal >= 90 then
        "XC" ++ toRoman (decimal - 90)

    else if decimal >= 50 then
        "L" ++ toRoman (decimal - 50)

    else if decimal >= 40 then
        "XL" ++ toRoman (decimal - 40)

    else if decimal >= 10 then
        "X" ++ toRoman (decimal - 10)

    else if decimal >= 9 then
        "IX" ++ toRoman (decimal - 9)

    else if decimal >= 5 then
        "V" ++ toRoman (decimal - 5)

    else if decimal >= 4 then
        "IV" ++ toRoman (decimal - 4)

    else if decimal > 0 then
        "I" ++ toRoman (decimal - 1)

    else
        ""
