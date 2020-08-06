module TwelveDays exposing (recite)

import Array exposing (Array, get)
import List exposing (map, range, reverse)
import Maybe exposing (withDefault)


recite : Int -> Int -> List String
recite start stop =
    List.range start stop
        |> List.map verse


verse : Int -> String
verse n =
    "On the " ++ ordinal n ++ " day of Christmas my true love gave to me: " ++ wayTooManyGifts n


ordinal : Int -> String
ordinal n =
    get (n - 1) ordinals |> withDefault "nth"


ordinals : Array String
ordinals =
    Array.fromList
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


wayTooManyGifts : Int -> String
wayTooManyGifts n =
    range 1 n |> reverse |> map gift |> String.concat


gift : Int -> String
gift n =
    get (n - 1) gifts |> withDefault "you shall never reach me, "


gifts : Array String
gifts =
    Array.fromList
        [ "a Partridge in a Pear Tree."
        , "two Turtle Doves, and "
        , "three French Hens, "
        , "four Calling Birds, "
        , "five Gold Rings, "
        , "six Geese-a-Laying, "
        , "seven Swans-a-Swimming, "
        , "eight Maids-a-Milking, "
        , "nine Ladies Dancing, "
        , "ten Lords-a-Leaping, "
        , "eleven Pipers Piping, "
        , "twelve Drummers Drumming, "
        ]
