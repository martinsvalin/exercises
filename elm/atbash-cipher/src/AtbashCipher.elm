module AtbashCipher exposing (decode, encode)

import Dict exposing (Dict)
import List exposing (filterMap, map, map2, reverse)
import List.Extra exposing (greedyGroupsOf)
import String exposing (fromList, join, toList, toLower)


encode : String -> String
encode =
    let
        key =
            cipherKey
                (numbers ++ alphabet)
                (numbers ++ reverse alphabet)
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
            cipherKey
                (numbers ++ reverse alphabet)
                (numbers ++ alphabet)
    in
    toList
        >> filterMap (translateChar key)
        >> fromList


translateChar : Dict Char Char -> Char -> Maybe Char
translateChar key char =
    Dict.get char key


cipherKey : List Char -> List Char -> Dict Char Char
cipherKey from to =
    map2 Tuple.pair from to |> Dict.fromList


alphabet : List Char
alphabet =
    toList "abcdefghijklmnopqrstuvwxyz"


numbers : List Char
numbers =
    toList "0123456789"
