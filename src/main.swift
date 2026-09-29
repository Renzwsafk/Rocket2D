import Foundation

struct EnvItem {
    var rect: Rectangle
    var blocking: Bool
    var color: Color
}

struct Rocket {
    var position: Vector2
    var velocity: Vector2
    
    var active: Bool
}

var ammo: Int32 = 5

var rockets: [Rocket] = []

    // let otherTextureLoc: String = "crosshair.png"

    //var crosshairPosition: Vector2 = Vector2(x: Float(-200.0), y: Float(-200.0))
InitWindow(windowWidth, windowHeight, windowName)
SetTargetFPS(defaultFPS)
    
    /*
    guard let path = Bundle.main.path(forResource: textureLoc, ofType: "png") else {
        fatalError("crosshair.png not found in bundle")
    }
    
    print("LOADED FROM:", path)
     */

let crosshair: Texture2D = LoadTexture(textureLoc)
let playerTexture: Texture2D = LoadTexture(playerLoc)
var soldier: Player = Player(position: Vector2(x: 400, y: 280), speed: 0, canJump: false,  hitObstacle: true, texture: playerTexture)

let envItems: [EnvItem] = [
    
    EnvItem(
        rect: Rectangle(x: 0, y: Float(windowHeight) * 0.8, width: Float(windowWidth), height: Float(windowHeight) * 0.2),
        blocking: true,
        color: Color.gray
    ),
    
    EnvItem(
        rect: Rectangle(x: Float(windowWidth) * 0.25, y: Float(windowHeight) * 0.4, width: Float(windowWidth) * 0.3, height: 10),
        blocking: true,
        color: Color.gray
    ),
    
    EnvItem(
        rect: Rectangle(x: Float(windowWidth) * 0.15, y: Float(windowHeight) * 0.6, width: Float(windowWidth) * 0.15, height: 10),
        blocking: true,
        color: Color.gray
    ),
    
    EnvItem(
        rect: Rectangle(x: Float(windowWidth) * 0.65, y: Float(windowHeight) * 0.6 + 9, width: Float(windowWidth) * 0.15, height: 10),
        blocking: true,
        color: Color.gray
    )
]

var camera: Camera2D = Camera2D(offset: Vector2(x: Float(windowWidth) / 2.0, y: Float(windowHeight) / 2.0), target: soldier.position, rotation: 0, zoom: 2)
while !WindowShouldClose() {
        
    let deltaTime: Float = Float(GetFrameTime())
        
    //HideCursor()
    
    updateCameraCenter(camera: &camera, player: soldier, width: windowWidth, height: windowHeight)
    cameraMovement(camera: &camera, deltaTime: deltaTime)
    if IsMouseButtonPressed(Int32(MOUSE_BUTTON_LEFT.rawValue)) && ammo > 0{
        let currentTime = GetTime()
        
        if currentTime - lastShotTime >= shootCooldown {
            lastShotTime = currentTime
            
            let mousePosition: Vector2 = GetMousePosition()
            var dir: Vector2 = Vector2(x: mousePosition.x - soldier.position.x, y: mousePosition.y - soldier.position.y)
            let length = sqrtf(dir.x * dir.x + dir.y * dir.y)
            
            dir.x /= length
            dir.y /= length
            
            let rocket: Rocket = Rocket(
                position: soldier.position,
                velocity: Vector2(
                    x: dir.x * 12,
                    y: dir.y * 12
                ),
                
                active: true
            )
            
            rockets.append(rocket)
            ammo -= 1
            
        }
    }
    
    
    
    for i in 0..<rockets.count {
        if rockets[i].active {
            rockets[i].position.x += rockets[i].velocity.x
            rockets[i].position.y += rockets[i].velocity.y
            
            if rockets[i].position.x < 0 || rockets[i].position.x > Float(windowWidth) || rockets[i].position.y < 0 || rockets[i].position.y > Float(windowHeight) {
                rockets[i].active = false
            }
        }
    }
    BeginDrawing()
        
    DrawFPS(30, 30)
    ClearBackground(Color.yellow)
    BeginMode2D(camera)
   
    for env in envItems {
            DrawRectangleRec(env.rect, env.color)
    }
    
    //DrawTexture(soldier.texture, Int32(soldier.position.x - 10), Int32(soldier.position.y - 200), Color.white)
    
    let playerRect = Rectangle(
            x: soldier.position.x - 20,
            y: soldier.position.y - 40,
            width: 40,
            height: 40
    )
   
    DrawRectangleRec(playerRect, Color.blue)

    for rocket in rockets {
        if rocket.active {
            DrawRectangleV(rocket.position, Vector2(x: 31, y: 24), Color.red)
        }
    }
    
    DrawText(String(ammo), 30, windowHeight - 30, 50, Color.red)
    
    // If rocket hits the platform, it generates a blast that will increment the player's velocity and pushes them
    // the blast is a circle
    // When the player is inside the circle after the collision, it will send the player into the air
    
    
    
    
    
    
    //DrawTexture(crosshair, Int32(crosshairPosition.x), Int32(crosshairPosition.y), Color.white)
    
    soldier.update(deltaTime: deltaTime, envItems: envItems)
    EndMode2D()
        
    EndDrawing()
}
    
    
CloseWindow()

