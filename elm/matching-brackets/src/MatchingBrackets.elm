module MatchingBrackets exposing (isPaired)

import Parser exposing ((|.), Parser, Step(..), chompIf, chompWhile, end, loop, map, oneOf, run, succeed, symbol)


isPaired : String -> Bool
isPaired input =
    case run parser input of
        Ok _ ->
            True

        Err _ ->
            False


parser : Parser ()
parser =
    loop end inner


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
    succeed ()
        |. symbol open
        |. loop (symbol close) inner


other : Parser ()
other =
    let
        regular char =
            not <| List.member char (String.toList "([{}])")
    in
    chompIf regular |. chompWhile regular
