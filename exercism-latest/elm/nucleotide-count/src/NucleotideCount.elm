module NucleotideCount exposing (nucleotideCounts)


type alias NucleotideCounts =
    { a : Int
    , t : Int
    , c : Int
    , g : Int
    }


nucleotideCounts : String -> NucleotideCounts
nucleotideCounts sequence =
    String.foldl count empty sequence


empty : NucleotideCounts
empty =
    NucleotideCounts 0 0 0 0


count : Char -> NucleotideCounts -> NucleotideCounts
count acid counts =
    case Char.toUpper acid of
        'A' ->
            { counts | a = counts.a + 1 }

        'T' ->
            { counts | t = counts.t + 1 }

        'C' ->
            { counts | c = counts.c + 1 }

        'G' ->
            { counts | g = counts.g + 1 }

        _ ->
            counts
