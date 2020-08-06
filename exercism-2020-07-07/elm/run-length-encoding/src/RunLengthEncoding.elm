module RunLengthEncoding exposing (decode, encode)

import Parser exposing ((|=), Parser, Step(..), int, loop, map, oneOf, succeed, token, variable)
import Set


type alias RunLengthEncoder =
    List ( Int, String )


encode : String -> String
encode string =
    case Parser.run encodeParser string of
        Ok lengths ->
            List.map pairToString lengths
                |> String.join ""

        Err _ ->
            string


pairToString : ( Int, String ) -> String
pairToString lengthAndString =
    case lengthAndString of
        ( 1, string ) ->
            string

        ( n, string ) ->
            String.fromInt n ++ string


encodeParser : Parser RunLengthEncoder
encodeParser =
    let
        charCounter list =
            case list of
                --  If we're at the first character, we must have one of a lonely character or end of string at this position
                [] ->
                    oneOf
                        [ succeed (\item -> Loop (item :: list))
                            |= lonely
                        , endLoop list
                        ]

                --  If we're into the string, we have one of: the last character seen, a new lonely character, or end of string
                ( n, s ) :: rest ->
                    oneOf
                        [ succeed (\_ -> Loop (( n + 1, s ) :: rest))
                            |= token s
                        , succeed (\item -> Loop (item :: ( n, s ) :: rest))
                            |= lonely
                        , endLoop list
                        ]
    in
    loop [] charCounter


decode : String -> String
decode string =
    case Parser.run decodeParser string of
        Ok pairs ->
            List.foldl (\( n, s ) -> \acc -> acc ++ String.repeat n s) "" pairs

        Err _ ->
            string


decodeParser : Parser RunLengthEncoder
decodeParser =
    let
        countedChar list =
            oneOf
                [ succeed (\item -> Loop (item :: list))
                    |= lengthAndCharacter
                , succeed (\item -> Loop (item :: list))
                    |= lonely
                , endLoop list
                ]
    in
    loop [] countedChar


lengthAndCharacter : Parser ( Int, String )
lengthAndCharacter =
    succeed Tuple.pair
        |= int
        |= singleCharacter


lonely : Parser ( Int, String )
lonely =
    succeed (Tuple.pair 1)
        |= singleCharacter


singleCharacter : Parser String
singleCharacter =
    variable { start = \_ -> True, inner = \_ -> False, reserved = Set.empty }


endLoop : List a -> Parser (Step state (List a))
endLoop list =
    succeed () |> map (\_ -> Done (List.reverse list))
