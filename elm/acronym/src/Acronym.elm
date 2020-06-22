module Acronym exposing (abbreviate)

import Regex exposing (Regex)


abbreviate : String -> String
abbreviate phrase =
    phrase
        |> Regex.find first
        |> List.map .match
        |> String.concat
        |> String.toUpper


first : Regex
first =
    -- word characters preceeded by start of string or non-word character
    Regex.fromString "(?<=^|\\W)\\w" |> Maybe.withDefault Regex.never
