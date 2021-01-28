/*
Три головы Змея Горыныча 3 часа смотрят в разные стороны.
 Первая голова 10 минут вперёд, затем 10 минут назад, потом 10 минут налево и 10 минут направо, снова 10 минут вперёд и так далее по циклу.
 Вторая голова 15 минут смотрит назад, затем 15 минут налево, потом 15 минут направо, снова назад и так далее по циклу.
 Третья голова 20 минут смотрит направо, 20 минут налево, 20 минут вперёд, снова направо и так далее по циклу.
 Сколько минут все три головы смотрели в одну сторону одновременно?
*/

func headIsLooking(head: inout Int, looksInDirection array: [String], amount: Int, time: Int) {
    if time % amount == 0 {
        head += 1
        if head == array.count {
            head = 0
        }
    }
}

var totalTime = 0

var firstHead = 0
var secondHead = 0
var thirdHead = 0

let firstHeadLooks = ["up", "down", "left", "right"]
let secondHeadLooks = ["down", "left", "right"]
let thirdHeadLooks = ["right", "left", "up"]

for time in 1 ... 180 {
    headIsLooking(head: &firstHead, looksInDirection: firstHeadLooks, amount: 10, time: time)
    headIsLooking(head: &secondHead, looksInDirection: secondHeadLooks, amount: 15, time: time)
    headIsLooking(head: &thirdHead, looksInDirection: thirdHeadLooks, amount: 20, time: time)

    if (firstHeadLooks[firstHead] == secondHeadLooks[secondHead])
        && (firstHeadLooks[firstHead] == thirdHeadLooks[thirdHead]) {

        totalTime += 1
    }
}

print("Total time equals: \(totalTime) minutes")
