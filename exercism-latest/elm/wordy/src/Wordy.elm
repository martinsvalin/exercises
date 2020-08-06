module Wordy exposing (answer)

import Parser exposing ((|.), (|=), Parser, Step(..), end, int, loop, map, oneOf, succeed, symbol, token)


type Expression
    = Expression Int (List Operation)


type Operation
    = Binary (Int -> Int -> Int) Int
    | Unary (Int -> Int)


answer : String -> Maybe Int
answer problem =
    case Parser.run parse problem of
        Err _ ->
            Nothing

        Ok expression ->
            Just (eval expression)


{-| Evaluate expression
An expression holds a left-hand-side value and a list of operations and their right-hand-side values.
Recursively apply operations on the lhs value until the list is empty.
-}
eval : Expression -> Int
eval equation =
    case equation of
        Expression lhs [] ->
            lhs

        Expression lhs ((Binary op rhs) :: ops) ->
            eval (Expression (op lhs rhs) ops)

        Expression lhs ((Unary op) :: ops) ->
            eval (Expression (op lhs) ops)



-- PARSER


{-| Parse a problem with a number and zero or more operations to apply on that number.
-}
parse : Parser Expression
parse =
    succeed Expression
        |. token "What is "
        |= number
        |= loop [] operations
        |. symbol "?"
        |. end


{-| Parse operations with their values
Supported operations are negation, addition, subtraction, multiplication, division and exponentiation.
-}
operations : List Operation -> Parser (Step (List Operation) (List Operation))
operations ops =
    oneOf
        [ map (\() -> Loop (Unary negate :: ops)) <|
            token " negated"
        , succeed (\n -> Loop (Binary (+) n :: ops))
            |. token " plus "
            |= number
        , succeed (\n -> Loop (Binary (-) n :: ops))
            |. token " minus "
            |= number
        , succeed (\n -> Loop (Binary (*) n :: ops))
            |. token " multiplied by "
            |= number
        , succeed (\n -> Loop (Binary (//) n :: ops))
            |. token " divided by "
            |= number
        , succeed (\n -> Loop (Binary (^) n :: ops))
            |. token " raised to the "
            |= number
            |. oneOf [ token "st", token "nd", token "rd", token "th" ]
            |. token " power"
        , succeed (Done (List.reverse ops))
        ]


number : Parser Int
number =
    oneOf
        [ succeed negate
            |. symbol "-"
            |= int
        , int
        ]
