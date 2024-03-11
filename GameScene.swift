//
//  GameScene.swift
//  BiasStory
//
//  By Eduardo 10/03/24
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let background = BackgroundNode(name: "background")
    let bia = PlayerNode(name: "bia")
    let leftButton = SKSpriteNode(color: .init(red: 0.5, green: 0.6, blue: 0.6, alpha: 0.8), size: .init(width: 120, height: 120))
    
    var isWalking: Bool = false
    
    override func sceneDidLoad() {
        print("Scene did load")
        print(UIScreen.main.bounds)
        init_nodes()
        addChild(background)
        addChild(bia)
        addChild(leftButton)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.isEmpty { return }
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if leftButton.contains(location) {
            isWalking.toggle()
            if isWalking {
                print("Trying to walk")
                bia.changeAnim(.walk)
            } else {
                print("Trying to stop walking")
                bia.changeAnim(.idle)
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            background.position.x = location.x
        }
         
    }
    
    private func init_nodes() {
        background.position = .init(x: 429, y: 0)
        background.zPosition = 0
        
        bia.position = .init(x: 0, y: -80)
        bia.zPosition = 4
        
        leftButton.position = .init(x: -330, y: -110)
    }
}

