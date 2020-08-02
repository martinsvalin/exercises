val reverse = ::reverseWithFold

fun reverseTheEasyWay(input: String): String =
    input.reversed()

fun reverseWithFold(input: String): String =
    input.fold("") { reversed, char -> char + reversed }
