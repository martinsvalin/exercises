module AtbashCipher exposing (decode, encode)

import Dict exposing (Dict)
import List exposing (filterMap, map, map2, reverse)
import List.Extra exposing (greedyGroupsOf)
import String exposing (fromList, join, toList, toLower)


encode : String -> String
encode =
    let
        key =
            buildKey
    in
    toLower
        >> toList
        >> filterMap (translateChar key)
        >> greedyGroupsOf 5
        >> map fromList
        >> join " "


decode : String -> String
decode =
    let
        key =
            buildKey
    in
    toList
        >> filterMap (translateChar key)
        >> fromList


translateChar : Dict Char Char -> Char -> Maybe Char
translateChar key char =
    Dict.get char key


buildKey : Dict Char Char
buildKey =
    map2 Tuple.pair (alphabet ++ numbers) (reverse alphabet ++ numbers) |> Dict.fromList


alphabet : List Char
alphabet =
    toList "abcdefghijklmnopqrstuvwxyz"


numbers : List Char
numbers =
    toList "0123456789"
