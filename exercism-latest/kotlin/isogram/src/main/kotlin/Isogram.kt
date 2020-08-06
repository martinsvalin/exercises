object Isogram {

    fun isIsogram(input: String): Boolean =
        input
            .toLowerCase()
            .filter { it.isLetter() }
            .let { it.toSet().size == it.length }
}
