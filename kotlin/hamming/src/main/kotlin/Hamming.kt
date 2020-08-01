import java.lang.IllegalArgumentException

object Hamming {

    fun compute(leftStrand: String, rightStrand: String): Int {
        if (leftStrand.length == rightStrand.length) {
            var distance = 0
            for (i in leftStrand.indices) {
                if (leftStrand[i] != rightStrand[i]) distance++
            }
            return distance
        } else {
            throw IllegalArgumentException("left and right strands must be of equal length")
        }
    }
}
