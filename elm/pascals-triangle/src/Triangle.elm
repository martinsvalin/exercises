module Triangle exposing (rows)

import List exposing (drop, head, map2, reverse)


rows : Int -> List (List Int)
rows n =
    buildTriangle [] n


buildTriangle : List (List Int) -> Int -> List (List Int)
buildTriangle acc n =
    if n <= 0 then
        reverse acc

    else
        buildTriangle (expand (head acc) :: acc) (n - 1)


expand : Maybe (List Int) -> List Int
expand numbers =
    case numbers of
        Nothing ->
            [ 1 ]

        Just nums ->
            map2 (+) (zeroPad nums) (drop 1 (zeroPad nums))


zeroPad : List Int -> List Int
zeroPad list =
    0 :: reverse (0 :: list)
