module GradeSchool exposing (addStudent, allStudents, empty, studentsInGrade)

import Dict exposing (Dict)
import List exposing (sort)
import Maybe exposing (withDefault)
import Maybe.Extra exposing (unwrap)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Grade (List Student)


empty : School
empty =
    Dict.empty


addStudent : Grade -> Student -> School -> School
addStudent grade student =
    Dict.update grade (Just << addSortedToMaybeList student)


addSortedToMaybeList : comparable -> Maybe (List comparable) -> List comparable
addSortedToMaybeList student =
    unwrap [ student ] ((::) student >> sort)


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade =
    Dict.get grade >> withDefault []


allStudents : School -> List ( Grade, List Student )
allStudents =
    Dict.toList
