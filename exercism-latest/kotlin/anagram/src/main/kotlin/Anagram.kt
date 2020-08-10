class Anagram(input: String) {
    private val word = input.normalizeCase()
    private val letters = word.letters()

    fun match(anagrams: Collection<String>): Set<String> =
        anagrams.filter { anagram ->
            anagram.normalizeCase().let {
                it != word && it.letters() == letters
            }
        }.toSet()

    private fun String.normalizeCase() = this.toLowerCase()
    private fun String.letters() = this.toList().sorted()
}
