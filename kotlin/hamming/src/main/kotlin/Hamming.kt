import java.lang.IllegalArgumentException

object Hamming {

    fun compute(leftStrand: String, rightStrand: String): Int {
        if (leftStrand.length != rightStrand.length)
            throw IllegalArgumentException("left and right strands must be of equal length")
        else
            return leftStrand.foldIndexed(0) { i, distance, char ->
                if (char == rightStrand[i]) distance else distance.inc()
            }
    }
}