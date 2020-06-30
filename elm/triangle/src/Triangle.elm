module Triangle exposing (Triangle(..), triangleKind)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    check x y z |> Result.map kind


check : number -> number -> number -> Result String ( number, number, number )
check x y z =
    let
        sides =
            [ x, y, z ]

        sum =
            List.sum sides
    in
    if List.any (\side -> side <= 0) sides then
        Err "Invalid lengths"

    else if List.any (\side -> side * 2 >= sum) sides then
        Err "Violates inequality"

    else
        Ok ( x, y, z )


kind : ( number, number, number ) -> Triangle
kind ( x, y, z ) =
    if x == y && y == z then
        Equilateral

    else if x == y || x == z || y == z then
        Isosceles

    else
        Scalene
