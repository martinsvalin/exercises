module SpaceAge exposing (Planet(..), ageOn)


type Planet
    = Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Uranus
    | Neptune


ageOn : Planet -> Float -> Float
ageOn planet seconds =
    seconds / orbitalPeriodInSeconds planet



{-
   - Mercury: orbital period 0.2408467 Earth years
   - Venus: orbital period 0.61519726 Earth years
   - Earth: orbital period 1.0 Earth years, 365.25 Earth days, or 31557600 seconds
   - Mars: orbital period 1.8808158 Earth years
   - Jupiter: orbital period 11.862615 Earth years
   - Saturn: orbital period 29.447498 Earth years
   - Uranus: orbital period 84.016846 Earth years
   - Neptune: orbital period 164.79132 Earth years
-}


orbitalPeriodInSeconds : Planet -> Float
orbitalPeriodInSeconds planet =
    case planet of
        Mercury ->
            7600543.81992

        Venus ->
            19414149.052176

        Earth ->
            31557600

        Mars ->
            59354032.690079994

        Jupiter ->
            374355659.124

        Saturn ->
            929292362.8848

        Uranus ->
            2651370019.3296

        Neptune ->
            5200418560.032001
