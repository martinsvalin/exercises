module Triangle exposing (rows)


rows : Int -> List (List Int)
rows n =
    if n <= 0 then
        []

    else
        buildTriangle [] n


buildTriangle : List (List Int) -> Int -> List (List Int)
buildTriangle acc n =
    if n == 0 then
        List.reverse acc

    else
        case acc of
            [] ->
                buildTriangle [ [ 1 ] ] (n - 1)

            previous :: _ ->
                buildTriangle (expand [] previous :: acc) (n - 1)


expand : List Int -> List Int -> List Int
expand acc numbers =
    case numbers of
        x :: y :: rest ->
            expand (x + y :: acc) (y :: rest)

        _ ->
            1 :: List.reverse (1 :: acc)
