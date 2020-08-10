object Transpose {
    const val PLACEHOLDER = '\u0000'

    fun transpose(strings: List<String>): List<String> =
        0.until(longest(strings)).map { index ->
            strings
                .map { it.getOrElse(index) { PLACEHOLDER } }
                .joinToString("")
                .trimEnd(PLACEHOLDER)
                .replace(PLACEHOLDER, ' ')
        }

    private fun longest(strings: List<String>): Int =
        strings.map { it.length }.max() ?: 0
}
