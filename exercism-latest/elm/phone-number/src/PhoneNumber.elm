module PhoneNumber exposing (getNumber)

import Parser exposing (..)


type alias PhoneNumber =
    { countryCode : Maybe String
    , areaCode : String
    , localNumber : String
    }


getNumber : String -> Maybe String
getNumber phoneNumber =
    case run parser phoneNumber of
        Ok parsedNumber ->
            Just (toString parsedNumber)

        Err _ ->
            Nothing


parser : Parser PhoneNumber
parser =
    succeed PhoneNumber
        |= countryCode
        |. junk
        |= areaCode
        |. junk
        |= localNumber
        |. junk
        |. end


toString : PhoneNumber -> String
toString phone =
    phone.areaCode ++ phone.localNumber


countryCode : Parser (Maybe String)
countryCode =
    oneOf
        [ symbol "+1" |> map (\_ -> Just "1")
        , symbol "1" |> map (\_ -> Just "1")
        , succeed Nothing
        ]


areaCode : Parser String
areaCode =
    succeed joinAreaCode
        |= digitFrom 2
        |= digitFrom 0
        |= digitFrom 0


localNumber : Parser String
localNumber =
    succeed joinLocalCode
        |= digitFrom 2
        |= digitFrom 0
        |= digitFrom 0
        |. junk
        |= digitFrom 0
        |= digitFrom 0
        |= digitFrom 0
        |= digitFrom 0


junk : Parser ()
junk =
    chompWhile (not << Char.isDigit)


digitFrom : Int -> Parser String
digitFrom start =
    let
        digits =
            List.range start 9 |> List.map String.fromInt |> String.concat |> String.toList
    in
    chompIf (\c -> List.member c digits) |> getChompedString


joinAreaCode : String -> String -> String -> String
joinAreaCode a b c =
    a ++ b ++ c


joinLocalCode : String -> String -> String -> String -> String -> String -> String -> String
joinLocalCode a b c d e f g =
    a ++ b ++ c ++ d ++ e ++ f ++ g
