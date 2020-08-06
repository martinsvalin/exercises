object Pangram {
    private val ALPHABET = ('a'..'z').toSet()

    fun isPangram(input: String): Boolean =
        input
            .toLowerCase()
            .toList()
            .containsAll(ALPHABET)
}
