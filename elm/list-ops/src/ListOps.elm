module ListOps exposing
    ( append
    , concat
    , filter
    , foldl
    , foldr
    , length
    , map
    , reverse
    )


length : List a -> Int
length list =
    case list of
        [] ->
            0

        _ :: xs ->
            1 + length xs


reverse : List a -> List a
reverse list =
    foldl (::) [] list


foldl : (a -> b -> b) -> b -> List a -> b
foldl f acc list =
    case list of
        [] ->
            acc

        x :: xs ->
            foldl f (f x acc) xs


foldr : (a -> b -> b) -> b -> List a -> b
foldr f acc list =
    reverse list |> foldl f acc


map : (a -> b) -> List a -> List b
map f list =
    foldr (f >> (::)) [] list


filter : (a -> Bool) -> List a -> List a
filter f list =
    let
        consIf x acc =
            if f x then
                x :: acc

            else
                acc
    in
    foldr consIf [] list


append : List a -> List a -> List a
append xs ys =
    foldr (::) ys xs


concat : List (List a) -> List a
concat list =
    foldr append [] list
