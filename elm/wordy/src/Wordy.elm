module Wordy exposing (answer)

import Parser exposing ((|.), (|=), Parser, Step(..), end, int, loop, map, oneOf, succeed, symbol, token)


type Expression
    = Expression Int (List Operation)


type Operation
    = Addition Int
    | Subtraction Int
    | Multiplication Int
    | Division Int


answer : String -> Maybe Int
answer problem =
    case Parser.run parse problem of
        Err _ ->
            Nothing

        Ok expression ->
            Just (eval expression)


{-| Evaluate expression
An expression holds a left-hand-side value and a list of operations with right-hand-side values.
Recursively apply operations on the lhs value until the list is empty.
-}
eval : Expression -> Int
eval equation =
    case equation of
        Expression x [] ->
            x

        Expression x ((Addition y) :: ops) ->
            eval (Expression (x + y) ops)

        Expression x ((Subtraction y) :: ops) ->
            eval (Expression (x - y) ops)

        Expression x ((Multiplication y) :: ops) ->
            eval (Expression (x * y) ops)

        Expression x ((Division y) :: ops) ->
            eval (Expression (x // y) ops)



-- PARSER


{-| Parse a problem with a number and zero or more operations to apply on that number.
-}
parse : Parser Expression
parse =
    succeed Expression
        |. token "What is "
        |= number
        |= loop [] operations
        |. end


{-| Parse an operation with its right-hand-side value, stopping at a final question mark.
Supported operations are addition, subtraction, multiplication and division.
-}
operations : List Operation -> Parser (Step (List Operation) (List Operation))
operations ops =
    oneOf
        [ operator Addition " plus " |> map (\op -> Loop (op :: ops))
        , operator Subtraction " minus " |> map (\op -> Loop (op :: ops))
        , operator Multiplication " multiplied by " |> map (\op -> Loop (op :: ops))
        , operator Division " divided by " |> map (\op -> Loop (op :: ops))
        , symbol "?" |> map (\() -> Done (List.reverse ops))
        ]


operator : (Int -> Operation) -> String -> Parser Operation
operator op string =
    succeed op
        |. token string
        |= number


number : Parser Int
number =
    oneOf
        [ succeed negate
            |. symbol "-"
            |= int
        , int
        ]
