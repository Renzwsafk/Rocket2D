func updateCameraCenter(camera: inout Camera2D, player: Player, width: Int32, height: Int32) {
    camera.offset = Vector2(
           x: Float(width) / 2.0,
           y: Float(height) / 2.0
       )
       
       camera.target = player.position
}

func cameraMovement(camera: inout Camera2D, deltaTime: Float) {
    let rotationSpeed: Float = 5.0
    let rotationMax: Float = 7.0
    
    if IsKeyDown(Int32(KEY_D.rawValue)) && camera.rotation < rotationMax {
        camera.rotation += rotationMax * rotationSpeed * deltaTime
    } else if IsKeyUp(Int32(KEY_D.rawValue)) && camera.rotation > 0.0 {
        camera.rotation -= rotationMax * rotationSpeed * deltaTime
    }
    
    if IsKeyDown(Int32(KEY_A.rawValue)) && camera.rotation > -rotationMax {
        camera.rotation -= rotationMax * rotationSpeed * deltaTime
    } else if IsKeyUp(Int32(KEY_A.rawValue)) && camera.rotation < 0.0 {
        camera.rotation += rotationMax * rotationSpeed * deltaTime
    }
}

