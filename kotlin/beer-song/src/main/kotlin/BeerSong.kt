object BeerSong {
    fun verses(startBottles: Int, takeDown: Int): String =
        (startBottles downTo takeDown)
            .map(::verse)
            .joinToString("\n")

    fun verse(number: Int): String =
        when (number) {
            0 -> 
                """
                No more bottles of beer on the wall, no more bottles of beer.
                Go to the store and buy some more, 99 bottles of beer on the wall.

                """.trimIndent() 
            1 -> 
                """
                1 bottle of beer on the wall, 1 bottle of beer.
                Take it down and pass it around, no more bottles of beer on the wall.

                """.trimIndent() 
            2 -> 
                """
                2 bottles of beer on the wall, 2 bottles of beer.
                Take one down and pass it around, 1 bottle of beer on the wall.

                """.trimIndent() 
            else -> 
                """
                ${number} bottles of beer on the wall, ${number} bottles of beer.
                Take one down and pass it around, ${number - 1} bottles of beer on the wall.

                """.trimIndent() 
        }
}