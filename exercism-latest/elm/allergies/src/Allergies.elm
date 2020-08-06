module Allergies exposing (Allergy(..), isAllergicTo, toList)

import Bitwise


type Allergy
    = Eggs
    | Peanuts
    | Shellfish
    | Strawberries
    | Tomatoes
    | Chocolate
    | Pollen
    | Cats


isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
    Bitwise.and score (allergyScoreOf allergy) > 0


toList : Int -> List Allergy
toList score =
    -- I can't think of a way to enumerate the cases of a type.
    -- This list needs to be maintained if another Allergy case is added.
    [ Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats ]
        |> List.filter (\allergy -> isAllergicTo allergy score)


allergyScoreOf : Allergy -> Int
allergyScoreOf allergy =
    case allergy of
        Eggs ->
            1

        Peanuts ->
            2

        Shellfish ->
            4

        Strawberries ->
            8

        Tomatoes ->
            16

        Chocolate ->
            32

        Pollen ->
            64

        Cats ->
            128
