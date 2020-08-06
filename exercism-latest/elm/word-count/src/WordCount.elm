module WordCount exposing (wordCount)

import Dict exposing (Dict)
import Regex exposing (Regex)


wordCount : String -> Dict String Int
wordCount sentence =
    sentence
        |> String.toLower
        |> Regex.find words
        |> List.foldl (\{ match } counts -> Dict.update match countWord counts) Dict.empty


countWord : Maybe Int -> Maybe Int
countWord current =
    Just <| Maybe.withDefault 0 current + 1


words : Regex
words =
    Maybe.withDefault Regex.never <|
        -- quote inside word, or just word
        Regex.fromString "\\w+'\\w+|\\w+"
