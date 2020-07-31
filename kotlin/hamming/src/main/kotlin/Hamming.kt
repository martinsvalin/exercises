import java.lang.IllegalArgumentException

object Hamming {

    fun compute(leftStrand: String, rightStrand: String): Int =
        if (leftStrand.length == rightStrand.length)
            leftStrand
                .zip(rightStrand)
                .filter { it.first != it.second }
                .size
        else
            throw IllegalArgumentException("left and right strands must be of equal length")
}
