module Strain exposing (discard, keep)


keep : (a -> Bool) -> List a -> List a
keep =
    filter []


discard : (a -> Bool) -> List a -> List a
discard predicate =
    keep (not << predicate)


filter : List a -> (a -> Bool) -> List a -> List a
filter acc predicate list =
    case list of
        [] ->
            List.reverse acc

        x :: xs ->
            if predicate x then
                filter (x :: acc) predicate xs

            else
                filter acc predicate xs
