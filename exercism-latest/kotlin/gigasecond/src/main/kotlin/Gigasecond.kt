import java.time.LocalDate
import java.time.LocalDateTime
import java.time.temporal.ChronoUnit.SECONDS

class Gigasecond(origin: LocalDateTime) {
    constructor(originDate: LocalDate) : this(originDate.atTime(0, 0, 0))
    val date: LocalDateTime = origin.plus(1_000_000_000, SECONDS)
}
