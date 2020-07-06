module RomanNumerals exposing (toRoman)


toRoman : Int -> String
toRoman number =
    buildRomanNumeral "" number


buildRomanNumeral : String -> Int -> String
buildRomanNumeral roman decimal =
    if decimal >= 1000 then
        buildRomanNumeral (roman ++ "M") (decimal - 1000)

    else if decimal >= 900 then
        buildRomanNumeral (roman ++ "CM") (decimal - 900)

    else if decimal >= 500 then
        buildRomanNumeral (roman ++ "D") (decimal - 500)

    else if decimal >= 400 then
        buildRomanNumeral (roman ++ "CD") (decimal - 400)

    else if decimal >= 100 then
        buildRomanNumeral (roman ++ "C") (decimal - 100)

    else if decimal >= 90 then
        buildRomanNumeral (roman ++ "XC") (decimal - 90)

    else if decimal >= 50 then
        buildRomanNumeral (roman ++ "L") (decimal - 50)

    else if decimal >= 40 then
        buildRomanNumeral (roman ++ "XL") (decimal - 40)

    else if decimal >= 10 then
        buildRomanNumeral (roman ++ "X") (decimal - 10)

    else if decimal >= 9 then
        buildRomanNumeral (roman ++ "IX") (decimal - 9)

    else if decimal >= 5 then
        buildRomanNumeral (roman ++ "V") (decimal - 5)

    else if decimal >= 4 then
        buildRomanNumeral (roman ++ "IV") (decimal - 4)

    else if decimal > 0 then
        buildRomanNumeral (roman ++ "I") (decimal - 1)

    else
        roman
