object Raindrops {

    fun convert(n: Int): String {
        val sound = pling(n) + plang(n) + plong(n)
        if (sound.isEmpty())
            return n.toString()
        else
            return sound
    }

    private fun pling(n: Int): String = dropSound(n, 3, "Pling")
    private fun plang(n: Int): String = dropSound(n, 5, "Plang")
    private fun plong(n: Int): String = dropSound(n, 7, "Plong")

    private fun dropSound(n: Int, denominator: Int, sound: String): String =
        if (n % denominator == 0) sound else ""
}
