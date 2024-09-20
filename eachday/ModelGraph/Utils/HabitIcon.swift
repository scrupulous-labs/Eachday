import Foundation

enum HabitIcon: String {
    // Common activities
    case alarm = "alarm"
    case medicinePills = "pills"
    case medicineVial = "cross.vial"
    case comb = "comb"
    case subglasses = "sunglasses"
    case cart = "cart"
    case message = "message"
    case quote = "quote.opening"
    case headphones = "headphones"
    case basket = "basket"
    case screwdriver = "screwdriver"
    case wrench = "wrench.adjustable"
    case hammer = "hammer"
    case eyedropper = "eyedropper"
    case lock = "lock"
    case key = "key"
    case magnifyingGlass = "magnifyingglass"
    case umbrella = "umbrella"
    
    // Food and Celebrations
    case carrot = "carrot"
    case forkAndKnife = "fork.knife"
    case cupAndSaucer = "cup.and.saucer"
    case mug = "mug"
    case wineglass = "wineglass"
    case fryingPan = "frying.pan"
    case waterbottle = "waterbottle"
    case takeout = "takeoutbag.and.cup.and.straw"
    case birthdayCake = "birthday.cake"
    case popcorn = "popcorn"
    case party = "party.popper"
    case balloons = "balloon.2"
    case fireworks = "fireworks"
    case laserShow = "laser.burst"
    case megaphone = "megaphone"
    case socialDance = "figure.socialdance"
    case dice = "dice"
    case teddybear = "teddybear"
    case crown = "crown"
    case gift = "gift"
    case gameController = "gamecontroller"
    case arcade = "arcade.stick.console"
    
    // Work and Study
    case briefcase = "briefcase"
    case officeBuilding = "building.2"
    case graduationcap = "graduationcap"
    case backpack = "backpack"
    case squareroot = "x.squareroot"
    case compass = "compass.drawing"
    case pencil = "pencil.line"
    case pencilScribble = "pencil.and.scribble"
    case pencilOutline = "pencil.and.outline"
    case ruler = "pencil.and.ruler"
    case book = "book"
    case bookShelf = "books.vertical"
    case bookClosed = "book.closed"
    case magazine = "magazine"
    case newspaper = "newspaper"
    case bookmark = "bookmark"
    case phone = "phone"
    case folder = "folder"
    case tray = "tray.full"
    case archivebox = "archivebox"
    case externaldrive = "externaldrive"
    case keyboard = "keyboard"
    case printer = "printer"
    case web = "globe"
    case clipboard = "list.clipboard"
    case note = "note.text"
    case calendar = "calendar"
    case paperclip = "paperclip"
    case flag = "flag"
    case bell = "bell"
    case tag = "tag"
    case trash = "trash"
    
    // Home
    case house = "house"
    case chair = "chair"
    case sofa = "sofa"
    case loungeChair = "chair.lounge"
    case fireplace = "fireplace"
    case bed = "bed.double"
    case cabinet = "cabinet"
    case washer = "washer"
    case dryer = "dryer"
    case dishwasher = "dishwasher"
    case oven = "oven"
    case stove = "stove"
    case cooktop = "cooktop"
    case microwave = "microwave"
    case refrigerator = "refrigerator"
    case lightbulb = "lightbulb.max"
    case fan = "fan"
    case deskFan = "fan.desk"
    case floorFan = "fan.floor"
    case ceilingFan = "fan.ceiling"
    case deskLamp = "lamp.desk"
    case tableLamp = "lamp.table"
    case floorLamp = "lamp.floor"
    case ceilingLamp = "lamp.ceiling"
    case chandelier = "chandelier"
    case humidifier = "humidifier"
    case airConditioner = "air.conditioner.horizontal"
    case sink = "sink"
    case spigot = "spigot"
    case shower = "shower"
    case handheldShower = "shower.handheld"
    case bathtub = "bathtub"
    case toilet = "toilet"
    case blinds = "blinds.vertical.open"
    case door = "door.left.hand.open"
    case garageDoor = "door.garage.open"
    
    // Sports and Fitness
    case walk = "figure.walk"
    case run = "figure.run"
    case cardio = "figure.mixed.cardio"
    case yoga = "figure.yoga"
    case meditation = "figure.mind.and.body"
    case dumbbell = "dumbbell.fill"
    case weightLifting = "figure.strengthtraining.traditional"
    case soccerball = "soccerball"
    case baseball = "baseball"
    case basketball = "basketball"
    case football = "football"
    case tennisRacket = "tennis.racket"
    case hockeyPuck = "hockey.puck"
    case cricketBall = "cricket.ball"
    case tennisball = "tennisball"
    case volleyball = "volleyball"
    case skateboard = "skateboard"
    case snowboard = "snowboard"
    case skis = "skis"
    case surfboard = "surfboard"
    case sailboat = "sailboat"
    case golf = "figure.golf"
    case cycling = "figure.outdoor.cycle"
    case swimming = "figure.pool.swim"
    case badminton = "figure.badminton"
    case pickleball = "figure.pickleball"
    case waveform = "waveform.path.ecg"
    case trophy = "trophy"
    case medal = "medal"
    case shoes = "shoe.2"
    
    // Art and Creativity
    case musicMic = "music.mic"
    case musicNote = "music.note"
    case musicNoteList = "music.note.list"
    case metronome = "metronome"
    case amplifier = "amplifier"
    case piano = "pianokeys.inverse"
    case guitars = "guitars"
    case paintbrush = "paintbrush"
    case paintbrushPointed = "paintbrush.pointed"
    case paintpalette = "paintpalette"
    case magic = "wand.and.rays"
    case theater = "theatermasks"
    case theaterAndPaint = "theatermask.and.paintbrush"
    case text = "text.word.spacing"
    case paragraphsign = "paragraphsign"
    case signature = "signature"
    case scribble = "scribble.variable"
    case scissors = "scissors"
    case camera = "camera"
    case dance = "figure.dance"
    
    // Nature and animals
    case sunrise = "sun.horizon"
    case sun = "sun.max"
    case moon = "moon"
    case wind = "wind"
    case humidity = "humidity"
    case waves = "water.waves"
    case drop = "drop"
    case flame = "flame"
    case smoke = "smoke"
    case bolt = "bolt"
    case aqi = "aqi.medium"
    case sparkles = "sparkles"
    case pawprint = "pawprint"
    case hare = "hare"
    case tortoise = "tortoise"
    case dog = "dog"
    case cat = "cat"
    case lizard = "lizard"
    case bird = "bird"
    case ant = "ant"
    case ladybug = "ladybug"
    case fish = "fish"
    case globe = "globe.americas"
    case mountain = "mountain.2"
    case tree = "tree"
    case leaf = "leaf"
    case laurel = "laurel.trailing"
    
    // Travel
    case map = "map"
    case mappin = "mappin"
    case scooter = "scooter"
    case bicycle = "bicycle"
    case car = "car"
    case bus = "bus"
    case tram = "tram"
    case plane = "airplane"
    case ferry = "ferry"
    case truck = "truck.box"
    case fuelpump = "fuelpump"
    case evCharger = "ev.charger"
    case binoculars = "binoculars.fill"
    case beachUmbrella = "beach.umbrella"
    case tent = "tent"
    case signpost = "signpost.right"
    
    // Shapes and emojis
    case handsClap = "hands.clap"
    case handRaised = "hand.raised.fingers.spread"
    case handThumbsup = "hand.thumbsup"
    case handWave = "hand.wave"
    case eyes = "eyes"
    case mustache = "mustache"
    case power = "power"
    case simley = "face.smiling"
    case shoeprints = "shoeprints.fill"
    case checkmark = "checkmark.seal"
    case barchart = "chart.bar"
    case heart = "heart"
    case starOfLife = "staroflife"
}

enum HabitIconGroup {
    case commonActivites
    case foodAndCelebrations
    case workAndStudy
    case sportsAndFitness
    case artsAndCreativity
    case travel
    case natureAndAnimals
    case home
    case shapesAndEmojis
    
    
    func icons() -> [HabitIcon] {
        switch self {
        case .commonActivites:
            return [
                .alarm,
                .medicinePills,
                .medicineVial,
                .comb,
                .subglasses,
                .cart,
                .basket,
                .message,
                .quote,
                .headphones,
                .screwdriver,
                .wrench,
                .hammer,
                .eyedropper,
                .lock,
                .key,
                .magnifyingGlass,
                .umbrella
            ]

        case .foodAndCelebrations:
            return [
                .carrot,
                .forkAndKnife,
                .cupAndSaucer,
                .mug,
                .wineglass,
                .fryingPan,
                .waterbottle,
                .takeout,
                .birthdayCake,
                .popcorn,
                .party,
                .balloons,
                .fireworks,
                .laserShow,
                .megaphone,
                .socialDance,
                .dice,
                .teddybear,
                .crown,
                .gift,
                .gameController,
                .arcade
            ]

        case .workAndStudy:
            return [
                .briefcase,
                .officeBuilding,
                .graduationcap,
                .backpack,
                .squareroot,
                .compass,
                .pencil,
                .pencilScribble,
                .pencilOutline,
                .ruler,
                .book,
                .bookShelf,
                .bookClosed,
                .magazine,
                .newspaper,
                .bookmark,
                .phone,
                .folder,
                .tray,
                .archivebox,
                .externaldrive,
                .keyboard,
                .printer,
                .globe,
                .clipboard,
                .note,
                .calendar,
                .paperclip,
                .flag,
                .bell,
                .tag,
                .trash
            ]

        case .home:
            return [
                .house,
                .chair,
                .sofa,
                .loungeChair,
                .fireplace,
                .bed,
                .cabinet,
                .washer,
                .dryer ,
                .dishwasher ,
                .oven,
                .stove ,
                .cooktop ,
                .microwave,
                .refrigerator,
                .lightbulb,
                .fan,
                .deskFan,
                .floorFan,
                .ceilingFan,
                .deskLamp,
                .tableLamp,
                .floorLamp,
                .ceilingLamp,
                .chandelier,
                .humidifier,
                .airConditioner,
                .sink,
                .spigot,
                .shower,
                .handheldShower,
                .bathtub,
                .toilet,
                .blinds,
                .door,
                .garageDoor
            ]

        case .sportsAndFitness:
            return [
                .meditation,
                .walk,
                .run,
                .yoga,
                .cardio,
                .dumbbell,
                .weightLifting,
                .soccerball,
                .baseball,
                .basketball,
                .football,
                .cricketBall,
                .tennisball,
                .volleyball,
                .skateboard,
                .snowboard,
                .skis,
                .surfboard,
                .sailboat,
                .golf,
                .cycling,
                .swimming,
                .badminton,
                .pickleball,
                .waveform,
                .trophy,
                .medal,
                .shoes,
            ]
        
        case .artsAndCreativity:
            return [
                .musicMic,
                .musicNote,
                .musicNoteList,
                .metronome,
                .amplifier,
                .piano,
                .guitars,
                .paintbrush,
                .paintbrushPointed,
                .paintpalette,
                .magic,
                .theater,
                .theaterAndPaint,
                .text,
                .paragraphsign,
                .signature,
                .scribble,
                .scissors,
                .camera,
                .dance
            ]
            
        case .natureAndAnimals:
            return [
                .sunrise,
                .sun,
                .moon,
                .wind,
                .humidity,
                .waves,
                .drop,
                .flame,
                .smoke,
                .bolt,
                .sparkles,
                .aqi,
                .pawprint,
                .hare,
                .tortoise,
                .dog,
                .cat,
                .lizard,
                .bird,
                .ant,
                .ladybug,
                .fish,
                .globe,
                .mountain,
                .tree,
                .leaf,
                .laurel
            ]
            
        case .travel:
            return [
                .map,
                .mappin,
                .scooter,
                .bicycle,
                .car,
                .bus,
                .tram,
                .plane,
                .ferry,
                .truck,
                .fuelpump,
                .evCharger,
                .binoculars,
                .beachUmbrella,
                .tent,
                .signpost
            ]
        
        case .shapesAndEmojis:
            return [
                .handsClap,
                .handRaised,
                .handThumbsup,
                .handWave,
                .eyes,
                .mustache,
                .power,
                .simley,
                .shoeprints,
                .checkmark,
                .barchart,
                .heart,
                .starOfLife
            ]
        }
    }
}
