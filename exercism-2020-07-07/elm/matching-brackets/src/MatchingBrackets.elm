module MatchingBrackets exposing (isPaired)

import Parser exposing ((|.), Parser, Step(..), chompIf, chompWhile, end, loop, map, oneOf, run, symbol)
import Result.Extra exposing (isOk)


isPaired : String -> Bool
isPaired input =
    run (loop end inner) input |> isOk


inner : Parser a -> Parser (Step (Parser a) ())
inner stop =
    oneOf
        [ stop |> map (\_ -> Done ())
        , parenthesis |> map (\_ -> Loop stop)
        , brackets |> map (\_ -> Loop stop)
        , curlies |> map (\_ -> Loop stop)
        , other |> map (\_ -> Loop stop)
        ]


parenthesis : Parser ()
parenthesis =
    matchingSymbols "(" ")"


brackets : Parser ()
brackets =
    matchingSymbols "[" "]"


curlies : Parser ()
curlies =
    matchingSymbols "{" "}"


matchingSymbols : String -> String -> Parser ()
matchingSymbols open close =
    symbol open |. loop (symbol close) inner


other : Parser ()
other =
    let
        regular char =
            not <| List.member char (String.toList "([{}])")
    in
    chompIf regular |. chompWhile regular
