module TwelveDays exposing (recite)

import List exposing (map, range, reverse)
import List.Extra exposing (getAt)
import Maybe exposing (withDefault)


recite : Int -> Int -> List String
recite start stop =
    List.range start stop
        |> List.map verse


verse : Int -> String
verse n =
    "On the " ++ ordinal n ++ " day of Christmas my true love gave to me: " ++ aNewGiftAndAllGiftsOfPreviousDays n ++ "."


ordinal : Int -> String
ordinal n =
    getAt (n - 1)
        [ "first"
        , "second"
        , "third"
        , "fourth"
        , "fifth"
        , "sixth"
        , "seventh"
        , "eighth"
        , "ninth"
        , "tenth"
        , "eleventh"
        , "twelfth"
        ]
        |> withDefault "nth"


aNewGiftAndAllGiftsOfPreviousDays : Int -> String
aNewGiftAndAllGiftsOfPreviousDays n =
    range 1 n |> reverse |> map gift |> join


join : List String -> String
join gifts =
    case reverse gifts of
        [] ->
            ""

        x :: [] ->
            x

        last :: rest ->
            (String.join ", " <| reverse rest) ++ ", and " ++ last


gift : Int -> String
gift n =
    getAt (n - 1)
        [ "a Partridge in a Pear Tree"
        , "two Turtle Doves"
        , "three French Hens"
        , "four Calling Birds"
        , "five Gold Rings"
        , "six Geese-a-Laying"
        , "seven Swans-a-Swimming"
        , "eight Maids-a-Milking"
        , "nine Ladies Dancing"
        , "ten Lords-a-Leaping"
        , "eleven Pipers Piping"
        , "twelve Drummers Drumming"
        ]
        |> withDefault "you shall never reach me"
