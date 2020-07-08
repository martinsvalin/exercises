module Bob where
import String exposing (endsWith, isEmpty, toUpper, toLower, trim)

type Remark = Boring | Yelling | SilentTreatment | Nosy

hey : String -> String
hey remark =
  let
    consider : String -> Remark
    consider remark =
      if loud remark then Yelling
      else if questioning remark then Nosy
      else if silent remark then SilentTreatment
      else Boring

    loud : String -> Bool
    loud remark =
      toUpper remark == remark &&
      toLower remark /= remark

    questioning : String -> Bool
    questioning remark =
      endsWith "?" remark

    silent : String -> Bool
    silent remark =
      trim remark |> isEmpty

  in
    case consider remark of
      Boring -> "Whatever."
      Yelling -> "Whoa, chill out!"
      SilentTreatment -> "Fine. Be that way!"
      Nosy -> "Sure."