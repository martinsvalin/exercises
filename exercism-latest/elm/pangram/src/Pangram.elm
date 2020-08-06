module Pangram exposing (isPangram)

import Set


isPangram : String -> Bool
isPangram =
    String.toLower
        >> String.toList
        >> List.filter Char.isLower
        >> Set.fromList
        >> Set.size
        >> (==) 26
