func collision(position: inout Vector2, speed: inout Float, hit: inout Bool, envItems: [EnvItem], deltaTime: Float) {
    for env in envItems {
        if env.blocking && env.rect.x <= position.x && env.rect.x + env.rect.width >= position.x &&
            env.rect.y >= position.y && env.rect.y <= position.y + speed * deltaTime {
            
           
        }
    }

}

/*
hit = false
speed = 0
position.y = env.rect.y

break
*/

struct Player {
    
    var position: Vector2
    var speed: Float
    var canJump: Bool
    var hitObstacle: Bool
    
    var texture: Texture2D
    
    mutating func update(deltaTime: Float, envItems: [EnvItem]) {
        
        hitObstacle = false
        
        if IsKeyDown(Int32(KEY_D.rawValue)) { position.x += plr_hor_spd*deltaTime }
        if IsKeyDown(Int32(KEY_A.rawValue)) { position.x -= plr_hor_spd*deltaTime }
        
        if IsKeyDown(Int32(KEY_SPACE.rawValue)) && canJump {
            speed = -plr_jmp_spd
            canJump = false
        }
        
        if IsKeyDown(Int32(MOUSE_BUTTON_LEFT.rawValue)) {
            
        }
        
        collision(position: &position,speed: &speed, hit: &hitObstacle, envItems: envItems, deltaTime: deltaTime)

        if !hitObstacle {
            position.y += speed * deltaTime
            speed += gravity * deltaTime
            canJump = false
        } else {
            canJump = true
        }
        
        if position.y > Float(windowHeight) {
            DrawText("GAME OVER", windowWidth / 2, windowHeight / 2, 50, Color.red)
        }
        
    }
}
