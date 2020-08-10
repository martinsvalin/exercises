object Transpose {

    fun transpose(strings: List<String>): List<String> =
        0.until(longest(strings)).map { index ->
            strings
                .map { it.getOrNull(index) }
                .dropLastWhile { it == null } // trim on the right
                .map { it ?: ' ' } // pad with space on the left
                .joinToString("")
        }

    private fun longest(strings: List<String>): Int =
        strings.map { it.length }.max() ?: 0
}
