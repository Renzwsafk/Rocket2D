// Colors
extension Color {
    static let white = Color(r: 245, g: 245, b: 245, a: 255)
    static let black = Color(r: 0, g: 0, b: 0, a: 255)
    static let yellow = Color(r: 200, g: 220, b: 0, a: 255)
    static let red = Color(r: 255, g: 0, b: 0, a: 255)
    static let gray = Color(r: 120, g: 120, b: 120, a: 255)
    static let lightGray = Color(r: 200, g: 200, b: 200, a: 255)
    static let blue = Color(r: 0, g: 0, b: 255, a: 255)
}


// Texture file locations
let textureLoc: String = "/Users/darkethwager/Desktop/Codes/RocketJumper2D/RocketJumper2D/crosshair.png"
let playerLoc: String = "/Users/darkethwager/Desktop/Codes/RocketJumper2D/RocketJumper2D/sprite.png"


// Physics
let gravity: Float = 500.0
let plr_jmp_spd: Float = 250.0
let plr_hor_spd: Float = 250.0


// Window values
let windowWidth: Int32 = 1280
let windowHeight: Int32 = 832
let defaultFPS: Int32 = 61
let windowName: String = "Rocket2D"


// Time
let shootCooldown: Double = 0.7
var lastShotTime: Double = 0.0
