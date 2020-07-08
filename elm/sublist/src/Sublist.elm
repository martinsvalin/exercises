module Sublist exposing (ListComparison(..), sublist)

import List exposing (length, take)


type ListComparison
    = Equal
    | Superlist
    | Sublist
    | Unequal


sublist : List a -> List a -> ListComparison
sublist listA listB =
    if listA == listB then
        Equal

    else if length listA < length listB && isSublist listA listB then
        Sublist

    else if length listA > length listB && isSublist listB listA then
        Superlist

    else
        Unequal


isSublist : List a -> List a -> Bool
isSublist short long =
    case long of
        [] ->
            False

        _ :: rest ->
            if short == take (length short) long then
                True

            else
                isSublist short rest
