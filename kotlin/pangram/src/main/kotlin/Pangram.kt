object Pangram {
    val ALPHABET = "abcdefghijklmnopqrstuvwxyz".toCharArray().toSet()

    fun isPangram(input: String): Boolean {
        return input
            .toLowerCase()
            .toCharArray()
            .toSet()
            .intersect(ALPHABET)
            .size == 26
    }
}
