module RNATranscription exposing (toRNA)

import Result exposing (Result(..))


toRNA : String -> Result String String
toRNA dna =
    String.toList dna
        |> transcript []


transcript : List Char -> List Char -> Result String String
transcript acc chars =
    case chars of
        [] ->
            Ok (List.reverse acc |> String.fromList)

        'G' :: rest ->
            transcript ('C' :: acc) rest

        'A' :: rest ->
            transcript ('U' :: acc) rest

        'T' :: rest ->
            transcript ('A' :: acc) rest

        'C' :: rest ->
            transcript ('G' :: acc) rest

        _ ->
            Err "Invalid input"
