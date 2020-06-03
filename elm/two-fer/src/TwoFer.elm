module TwoFer exposing (twoFer)


twoFer : Maybe String -> String
twoFer name =
    "One for " ++ subject name ++ ", one for me."


subject : Maybe String -> String
subject name =
    case name of
        Nothing ->
            "you"

        Just name_ ->
            name_
