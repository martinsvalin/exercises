module PhoneNumber exposing (getNumber)

import List exposing (filterMap)
import Regex exposing (Match, Regex, find)


getNumber : String -> Maybe String
getNumber phoneNumber =
    case find pattern phoneNumber of
        -- Regex will give one or zero matches.
        [ match ] ->
            Just (join match)

        _ ->
            Nothing


pattern : Regex
pattern =
    Maybe.withDefault Regex.never <|
        Regex.fromString
            ("^"
                ++ -- ignore country code
                   "(?:\\+?1)?"
                ++ "\\D*"
                ++ -- area code, leading number is 2-9
                   "([2-9]\\d{2})"
                ++ "\\D*"
                ++ -- local number, leading number is 2-9
                   "([2-9]\\d{2})\\D*(\\d{4})"
                ++ "\\D*$"
            )


join : Match -> String
join =
    .submatches >> filterMap identity >> String.concat
