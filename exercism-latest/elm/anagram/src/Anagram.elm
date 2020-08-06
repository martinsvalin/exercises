module Anagram exposing (detect)

import List exposing (filter)
import String exposing (toLower)


detect : String -> List String -> List String
detect word candidates =
    filter (isAnagram <| toLower word) candidates


isAnagram : String -> String -> Bool
isAnagram word mixedCaseCandidate =
    let
        candidate =
            toLower mixedCaseCandidate
    in
    word /= candidate && sortedLetters word == sortedLetters candidate


sortedLetters : String -> List Char
sortedLetters =
    String.toList >> List.sort
