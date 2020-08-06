module Raindrops exposing (raindrops)


raindrops : Int -> String
raindrops number =
    case dropsFrom number of
        [] ->
            String.fromInt number

        drops ->
            String.concat drops


dropsFrom : Int -> List String
dropsFrom number =
    [ "Pling", "Plang", "Plong" ]
        |> List.map2 Tuple.pair [ 3, 5, 7 ]
        |> List.filterMap (dropFrom number)


dropFrom : Int -> ( Int, String ) -> Maybe String
dropFrom number ( factor, drop ) =
    if modBy factor number == 0 then
        Just drop

    else
        Nothing
