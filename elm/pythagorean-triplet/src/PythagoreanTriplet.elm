module PythagoreanTriplet exposing (triplets)

import Set


type alias Triplet =
    ( Int, Int, Int )


triplets : Int -> List Triplet
triplets limit =
    generateTripletsWithEuclidsFormula limit 2 []
        |> List.filterMap (sumToLimitBySomeMultiple limit)
        |> Set.fromList
        |> Set.toList


generateTripletsWithEuclidsFormula : Int -> Int -> List Triplet -> List Triplet
generateTripletsWithEuclidsFormula limit m acc =
    let
        newTriplets =
            List.range 1 (m - 1) |> List.map (euclidsFormula m)
    in
    -- stop generating triplets when their sum grows beyond the limit
    case List.filter (\( a, b, c ) -> a + b + c <= limit) newTriplets of
        [] ->
            acc |> List.sort

        new ->
            generateTripletsWithEuclidsFormula limit (m + 1) (new ++ acc)


euclidsFormula : Int -> Int -> Triplet
euclidsFormula m n =
    let
        a =
            m ^ 2 - n ^ 2

        b =
            2 * m * n

        c =
            m ^ 2 + n ^ 2
    in
    -- ensure the triplet is in a stable ascending order
    [ a, b, c ] |> List.sort |> toTriplet |> Maybe.withDefault ( a, b, c )


toTriplet : List Int -> Maybe Triplet
toTriplet list =
    case list of
        [ a, b, c ] ->
            Just ( a, b, c )

        _ ->
            Nothing


sumToLimitBySomeMultiple : Int -> Triplet -> Maybe Triplet
sumToLimitBySomeMultiple sum ( a, b, c ) =
    if modBy (a + b + c) sum == 0 then
        let
            k =
                sum // (a + b + c)
        in
        Just ( a * k, b * k, c * k )

    else
        Nothing
