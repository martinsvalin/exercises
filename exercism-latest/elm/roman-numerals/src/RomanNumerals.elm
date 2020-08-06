module RomanNumerals exposing (toRoman)


toRoman : Int -> String
toRoman number =
    List.foldr decimalToRoman ( number, "" ) numerals
        |> Tuple.second


decimalToRoman : ( Int, String ) -> ( Int, String ) -> ( Int, String )
decimalToRoman ( divisor, symbol ) ( numerator, roman ) =
    ( modBy divisor numerator
    , roman ++ String.repeat (numerator // divisor) symbol
    )


numerals : List ( Int, String )
numerals =
    [ ( 1, "I" )
    , ( 4, "IV" )
    , ( 5, "V" )
    , ( 9, "IX" )
    , ( 10, "X" )
    , ( 40, "XL" )
    , ( 50, "L" )
    , ( 90, "XC" )
    , ( 100, "C" )
    , ( 400, "CD" )
    , ( 500, "D" )
    , ( 900, "CM" )
    , ( 1000, "M" )
    ]
