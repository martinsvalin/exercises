module Gigasecond exposing (add)

import Time exposing (Posix, millisToPosix, posixToMillis)


add : Posix -> Posix
add timestamp =
    timestamp
        |> posixToMillis
        |> (+) (10 ^ 9 * 1000)
        |> millisToPosix
