module Say exposing (SayError(..), say)

import Dict


type SayError
    = Negative
    | TooLarge


say : Int -> Result SayError String
say number =
    if number == 0 then
        Ok "zero"

    else if number < 0 then
        Err Negative

    else if number >= 10000000000000000 then
        Err TooLarge

    else
        let
            ( hundreds, tens ) =
                formatHundreds number

            bigString =
                formatBigNumbers number
                    ++ [ hundreds ]
                    |> List.filterMap identity
                    |> String.join " "

            big =
                if String.isEmpty bigString then
                    Nothing

                else
                    Just bigString
        in
        ( big, tens )
            |> maybeJoin (\a b -> a ++ " and " ++ b)
            |> Maybe.withDefault "zero"
            |> Ok


formatBigNumbers : Int -> List (Maybe String)
formatBigNumbers number =
    [ ( 1000000000, " billion" )
    , ( 1000000, " million" )
    , ( 1000, " thousand" )
    ]
        |> List.map
            (\( mod, str ) ->
                (modBy (mod * 1000) number // mod)
                    |> formatHundreds
                    |> maybeJoin (\a b -> a ++ " and " ++ b)
                    |> Maybe.map (\c -> c ++ str)
            )


formatHundreds : Int -> ( Maybe String, Maybe String )
formatHundreds number =
    let
        hundreds =
            (format <| modBy 1000 number // 100) |> Maybe.map (\h -> h ++ " hundred")

        tens =
            formatTens number
    in
    ( hundreds, tens )


formatTens : Int -> Maybe String
formatTens n =
    case format (modBy 100 n) of
        Just tens ->
            Just tens

        Nothing ->
            let
                evenTens =
                    format (modBy 100 n // 10 * 10)

                ones =
                    format (modBy 10 n)
            in
            Maybe.map2 (\ten one -> ten ++ "-" ++ one) evenTens ones


format : Int -> Maybe String
format number =
    Dict.fromList
        [ ( 1, "one" )
        , ( 2, "two" )
        , ( 3, "three" )
        , ( 4, "four" )
        , ( 5, "five" )
        , ( 6, "six" )
        , ( 7, "seven" )
        , ( 8, "eight" )
        , ( 9, "nine" )
        , ( 10, "ten" )
        , ( 11, "eleven" )
        , ( 12, "twelve" )
        , ( 13, "thirteen" )
        , ( 14, "fourteen" )
        , ( 15, "fifteen" )
        , ( 16, "sixteen" )
        , ( 17, "seventeen" )
        , ( 18, "eighteen" )
        , ( 19, "nineteen" )
        , ( 20, "twenty" )
        , ( 30, "thirty" )
        , ( 40, "forty" )
        , ( 50, "fifty" )
        , ( 60, "sixty" )
        , ( 70, "seventy" )
        , ( 80, "eighty" )
        , ( 90, "ninety" )
        ]
        |> Dict.get number


maybeJoin : (a -> a -> a) -> ( Maybe a, Maybe a ) -> Maybe a
maybeJoin f ( maybeA, maybeB ) =
    case ( maybeA, maybeB ) of
        ( Just a, Just b ) ->
            Just (f a b)

        ( Just a, Nothing ) ->
            Just a

        ( Nothing, Just b ) ->
            Just b

        ( Nothing, Nothing ) ->
            Nothing
