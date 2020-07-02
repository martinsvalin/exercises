module BinarySearch exposing (find)

import Array exposing (Array, get, length, slice)


find : Int -> Array Int -> Maybe Int
find target xs =
    let
        middle =
            length xs // 2
    in
    case Maybe.map (compare target) (get middle xs) of
        Nothing ->
            Nothing

        Just EQ ->
            Just middle

        Just LT ->
            find target (slice 0 middle xs)

        Just GT ->
            find target (slice (middle + 1) (length xs) xs)
                |> Maybe.map ((+) (middle + 1))
