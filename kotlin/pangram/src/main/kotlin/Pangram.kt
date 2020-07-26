object Pangram {
    private val ALPHABET = ('a'..'z').toSet()

    fun isPangram(input: String): Boolean {
        return input
            .toLowerCase()
            .toList()
            .containsAll(ALPHABET)
    }
}
