module Strain exposing (discard, keep)


keep : (a -> Bool) -> List a -> List a
keep predicate =
    List.foldr
        (\a acc ->
            if predicate a then
                a :: acc

            else
                acc
        )
        []


discard : (a -> Bool) -> List a -> List a
discard predicate =
    keep (not << predicate)
