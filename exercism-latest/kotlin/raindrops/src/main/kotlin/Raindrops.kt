object Raindrops {

    fun convert(n: Int): String =
        (pling(n) + plang(n) + plong(n)).default(n.toString())

    private fun pling(n: Int): String = dropSound(n, 3, "Pling")
    private fun plang(n: Int): String = dropSound(n, 5, "Plang")
    private fun plong(n: Int): String = dropSound(n, 7, "Plong")

    private fun dropSound(n: Int, factor: Int, sound: String): String =
        if (n % factor == 0) sound else ""

    private fun String.default(default: String) =
        if (this.isEmpty()) default else this
}
