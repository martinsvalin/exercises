module Etl exposing (transform)

import Dict exposing (Dict)


transform : Dict Int (List String) -> Dict String Int
transform input =
    Dict.foldl
        (\score letters output ->
            List.foldl
                (\letter -> Dict.insert (String.toLower letter) score)
                output
                letters
        )
        Dict.empty
        input
