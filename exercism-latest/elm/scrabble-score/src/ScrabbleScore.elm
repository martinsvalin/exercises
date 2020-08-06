module ScrabbleScore exposing (scoreWord)

import Dict exposing (Dict)


scoreWord : String -> Int
scoreWord =
    String.foldl (addLetterScore letterScores) 0


addLetterScore : Dict Char Int -> Char -> Int -> Int
addLetterScore scores letter total =
    total + (Dict.get (Char.toLower letter) scores |> Maybe.withDefault 0)


letterScores : Dict Char Int
letterScores =
    Dict.fromList
        [ ( 'a', 1 )
        , ( 'b', 3 )
        , ( 'c', 3 )
        , ( 'd', 2 )
        , ( 'e', 1 )
        , ( 'f', 4 )
        , ( 'g', 2 )
        , ( 'h', 4 )
        , ( 'i', 1 )
        , ( 'j', 8 )
        , ( 'k', 5 )
        , ( 'l', 1 )
        , ( 'm', 3 )
        , ( 'n', 1 )
        , ( 'o', 1 )
        , ( 'p', 3 )
        , ( 'q', 10 )
        , ( 'r', 1 )
        , ( 's', 1 )
        , ( 't', 1 )
        , ( 'u', 1 )
        , ( 'v', 4 )
        , ( 'w', 4 )
        , ( 'x', 8 )
        , ( 'y', 4 )
        , ( 'z', 10 )
        ]
