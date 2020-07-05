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
length =
    foldl (\_ -> (+) 1) 0


reverse : List a -> List a
reverse =
    foldl (::) []


foldl : (a -> b -> b) -> b -> List a -> b
foldl f acc list =
    case list of
        [] ->
            acc

        x :: xs ->
            foldl f (f x acc) xs


foldr : (a -> b -> b) -> b -> List a -> b
foldr f acc =
    reverse >> foldl f acc


map : (a -> b) -> List a -> List b
map f =
    foldr (f >> (::)) []


filter : (a -> Bool) -> List a -> List a
filter f =
    let
        consIf x acc =
            if f x then
                x :: acc

            else
                acc
    in
    foldr consIf []


append : List a -> List a -> List a
append xs ys =
    foldr (::) ys xs


concat : List (List a) -> List a
concat =
    foldr append []
