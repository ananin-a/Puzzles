/*
 1. Создайте тип Комната. У комнаты есть размеры W на H. И создайте тип Персонаж.
 У него есть координата в комнате X и Y.
 Реализуйте функцию, которая красивенько текстом будет показывать положение персонажа в комнате
 2. Персонажу добавьте метод идти, который принимает энумчик лево, право, верх, вниз.
 Этот метод должен передвигать персонажа. Реализуйте правило что персонаж не должен покинуть пределы комнаты.
 Подвигайте персонажа и покажите это графически
 3. Создать тип Ящик. У ящика также есть координата в комнате X и Y. Ящик также не может покидать пределы комнаты и
 ящик также должен быть распечатан вместе с персонажем в функции печати.
 4. Теперь самое интересное, персонаж может двигать ящик, если он стоит на том месте, куда персонаж хочет попасть.
 Главное что ни один объект не может покинуть пределы комнаты. Подвигайте ящик :)
 5. Добавьте точку в комнате, куда надо ящик передвинуть и двигайте :)
 */

struct Room {
    static let width = 6
    static let height = 6
}

struct Box {
    static var xCoordinate = Room.height / 2 {
        didSet {
            switch xCoordinate {
            case 0:
                xCoordinate = oldValue
            case Room.height + 1:
                xCoordinate = oldValue
            default:
                print()
            }
        }
    }
    
    static var yCoordinate = Room.width / 2 {
        didSet {
            switch yCoordinate {
            case 0:
                yCoordinate = oldValue
            case Room.width + 1:
                yCoordinate = oldValue
            default:
                print()
            }
        }
    }
    var face: Character = "📦"
    static var score = 0
    
    mutating func checkFinish() {
        if Box.xCoordinate == Cesspool.xCoordinate && Box.yCoordinate == Cesspool.yCoordinate {
            self .face = "⬛️"
            Box.score += 1
        }
    }
}

struct Cesspool {
    static var xCoordinate = 1
    static var yCoordinate = Room.width
    var face: Character = "⬛️"
}


struct Hero {
    var damage = 1
    var death: Character = "☠️"
    var health = 3 {
        didSet {
            if self .health <= 0 {
                self .face = death
                print()
                print(" 💀 💀 💀 💀>>>GAME OVER<<<💀 💀 💀 💀")
                self .health = 0
            }
        }
    }
    var name: String
    var face: Character
    
    var xCoordinate = 1 {
        didSet {
            switch xCoordinate {
            case 0:
                xCoordinate = oldValue
                self.health -= self .damage
            case Room.width + 1:
                xCoordinate = oldValue
                self.health -= self .damage
            default:
                print()
            }
        }
    }
    
    var yCoordinate = 1 {
        didSet {
            switch yCoordinate {
            case 0:
                yCoordinate = oldValue
                self.health -= self .damage
            case Room.height + 1:
                yCoordinate = oldValue
                self.health -= self .damage
            default:
                print()
            }
        }
    }
    
    enum MovieDirection {
        case up, down, left, right
    }
    
    mutating func checkGoToCesspool() {
        if self .xCoordinate == Cesspool.xCoordinate && self .yCoordinate == Cesspool.yCoordinate {
            self .health = 0
        }
    }
    
    func checkCellOccupied() -> Bool {
        if self.xCoordinate == Box.xCoordinate && self .yCoordinate == Box.yCoordinate {
            return false
        }
        return true
    }
    
    mutating func moveTo(_ movie: MovieDirection) {
        if self .face != self .death && checkCellOccupied() {
            switch movie {
            case .up:
                yCoordinate -= 1
                checkGoToCesspool()
                if yCoordinate == Box.yCoordinate && xCoordinate == Box.xCoordinate {
                    Box.yCoordinate -= 1
                    box.checkFinish()
                }
            case .down:
                yCoordinate += 1
                checkGoToCesspool()
                if yCoordinate == Box.yCoordinate && xCoordinate == Box.xCoordinate {
                    Box.yCoordinate += 1
                    box.checkFinish()
                }
            case .left:
                xCoordinate -= 1
                checkGoToCesspool()
                if xCoordinate == Box.xCoordinate && yCoordinate == Box.yCoordinate {
                    Box.xCoordinate -= 1
                    box.checkFinish()
                }
            case .right:
                xCoordinate += 1
                checkGoToCesspool()
                if xCoordinate == Box.xCoordinate && yCoordinate == Box.yCoordinate {
                    Box.xCoordinate += 1
                    box.checkFinish()
                    
                }
            }
        } else {
            print()
            print(" 💀 💀 💀 💀>>>GAME OVER<<<💀 💀 💀 💀")
        }
    }
}

let room = Room()
var box = Box()
let cesspool = Cesspool()
var hero = Hero(name: "Hero", face: "🤠")

func printTopAndBotton() {
    for _ in 1...Room.height + 2 {
        print("🌲", terminator: " ")
    }
    print()
}

// print a room with a hero
func printRoom(_ room: Room, withHero hero: Hero, andBox box: Box, andCesspool cesspool: Cesspool) {
    if hero.health > 0 {
        print()
        print("  Hero \(hero.name) with a level of health = \(hero.health)")
        print("  Score = \(Box.score)")
    } else {
        print()
    }
    printTopAndBotton()
    for y in 1...Room.width {
        print("🌲", terminator: " ")
        for x in 1...Room.height {
            switch (hero.xCoordinate, hero.yCoordinate,
                    Box.xCoordinate, Box.yCoordinate,
                    Cesspool.xCoordinate, Cesspool.yCoordinate) {
            case (x, y, _, _, _, _):
                print(hero.face, terminator: " ")
            case (_, _, x, y, _, _):
                print(box.face, terminator: " ")
            case (_, _, _, _, x, y):
                print(cesspool.face, terminator: " ")
            default:
                print("⬜️", terminator: " ")
            }
        }
        print("🌲", terminator: "")
        print()
    }
    printTopAndBotton()
}

func moveTo(room: Room, hero: inout Hero , move: Hero.MovieDirection) {
    hero.moveTo(move)
    printRoom(room, withHero: hero, andBox: box, andCesspool: cesspool)
}

printRoom(room, withHero: hero, andBox: box, andCesspool: cesspool)

moveTo(room: room, hero: &hero, move: .right)
moveTo(room: room, hero: &hero, move: .right)
moveTo(room: room, hero: &hero, move: .down)
moveTo(room: room, hero: &hero, move: .down)
moveTo(room: room, hero: &hero, move: .down)
moveTo(room: room, hero: &hero, move: .down)
moveTo(room: room, hero: &hero, move: .right)
moveTo(room: room, hero: &hero, move: .down)
moveTo(room: room, hero: &hero, move: .left)
moveTo(room: room, hero: &hero, move: .left)
moveTo(room: room, hero: &hero, move: .left)
