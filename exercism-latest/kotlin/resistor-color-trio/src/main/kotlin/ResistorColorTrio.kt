import kotlin.math.pow

object ResistorColorTrio {
    // Produces a list like [1L to "ohms", 1000L to "kiloohms", 1000_000L to "megaohms", ...]
    // It would be clearer to write it out literally rather than transform Unit, but this is for practice.
    val units =
        Unit.values().withIndex().map { (index, unit) ->
            val multiple = 10.0.pow(index * 3).toLong()
            val unitName = unit.name.toLowerCase()
            multiple to unitName
        }

    // Signature is changed from vararg to 3-arity. It makes the contract clearer and allows better naming.
    fun text(tens: Color, ones: Color, zeroes: Color): String {
        val number = (tens.ordinal * 10 + ones.ordinal) * 10.0.pow(zeroes.ordinal).toLong()
        val (multiple, unit) = units.findLast { number % it.first == 0L }!!

        return "${number / multiple} $unit"
    }
}
