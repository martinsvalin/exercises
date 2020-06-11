module Sublist exposing (ListComparison(..), sublist)

import List exposing (length)


type ListComparison
    = Equal
    | Superlist
    | Sublist
    | Unequal


sublist : List a -> List a -> ListComparison
sublist shortest longest =
    case compare (length shortest) (length longest) of
        LT ->
            case ( shortest, longest ) of
                ( _, [] ) ->
                    Unequal

                ( _, _ :: longTail ) ->
                    -- check both current and next, to avoid mistaking a Sublist for Equal
                    if startSame shortest longest || startSame shortest longTail then
                        Sublist

                    else
                        sublist shortest longTail

        EQ ->
            if startSame shortest longest then
                Equal

            else
                Unequal

        GT ->
            case sublist longest shortest of
                Sublist ->
                    Superlist

                other ->
                    other


startSame : List a -> List a -> Bool
startSame listA listB =
    case ( listA, listB ) of
        ( [], _ ) ->
            True

        ( _, [] ) ->
            False

        ( x :: tailA, y :: tailB ) ->
            x == y && startSame tailA tailB
