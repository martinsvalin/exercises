module Tests exposing (tests)

import Expect
import NucleotideCount exposing (nucleotideCounts)
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "NucleotideCount"
        [ test "empty dna strand has no nucleotides" <|
            \() ->
                Expect.equal { a = 0, t = 0, c = 0, g = 0 }
                    (nucleotideCounts "")
        , test "repetitive sequence has only guanine" <|
            \() ->
                Expect.equal { a = 0, t = 0, c = 0, g = 8 }
                    (nucleotideCounts "GGGGGGGG")
        , test "counts all nucleotides" <|
            \() ->
                Expect.equal { a = 20, t = 21, c = 12, g = 17 }
                    (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
        , test "ignores whitespace" <|
            \() ->
                Expect.equal { a = 0, t = 0, c = 0, g = 8 }
                    (nucleotideCounts "GGGG GGGG")
        , test "counts both lower and upper case" <|
            \() ->
                Expect.equal { a = 3, c = 1, g = 1, t = 2 }
                    (nucleotideCounts "GaTtAca")
        , test "ignores unknown acids" <|
            \() ->
                Expect.equal { a = 2, c = 2, g = 0, t = 1 }
                    (nucleotideCounts "CATSCAN")
        ]
