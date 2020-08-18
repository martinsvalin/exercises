object PigLatin {
    fun translate(phrase: String): String =
        phrase.words().map(::toPigLatin).joinToString(" ")

    private fun toPigLatin(word: String): String {
        if ("aeiou".any { word.startsWith(it) }) {
            return word + "ay"
        } else if (word.first() in "xy" && word.drop(1).first().isConsonant()) {
            return word + "ay"
        } else if (word.startsWith("y")) {
            return word.drop(1) + "yay"
        } else if (word.startsWith("qu")) {
            return word.drop(2) + "quay"
        } else if (word.first().isConsonant() && word.drop(1).startsWith("qu")) {
            return word.drop(3) + word.first() + "quay"
        } else {
            return word
                .takeWhile {it.isConsonant()}
                .let { prefix -> word.drop(prefix.length) + prefix + "ay" }
        }
    }
    
    private fun String.words() = this.split(' ')
    private fun Char.isVowel() = this in "aeiou"
    private fun Char.isConsonant() = !this.isVowel() && this != 'y'
}
