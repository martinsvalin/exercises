module AllYourBase exposing (rebase)


rebase : Int -> List Int -> Int -> Maybe (List Int)
rebase inBase digits outBase =
    if valid inBase digits outBase then
        Just (digits |> toNumber inBase |> toDigits outBase |> List.reverse)

    else
        Nothing


toNumber : Int -> List Int -> Int
toNumber base =
    List.foldr (\digit ( sum, pow ) -> ( sum + digit * base ^ pow, pow + 1 )) ( 0, 0 ) >> Tuple.first


toDigits : Int -> Int -> List Int
toDigits base number =
    case ( number // base, remainderBy base number ) of
        ( 0, remainder ) ->
            [ remainder ]

        ( quotient, remainder ) ->
            remainder :: toDigits base quotient


valid : Int -> List Int -> Int -> Bool
valid inBase digits outBase =
    inBase > 1 && outBase > 1 && List.sum digits > 0 && List.all (\d -> 0 <= d && d < inBase) digits
