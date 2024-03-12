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
    let leftButton = ButtonNode(name: "leftButton")
    let rightButton = ButtonNode(name: "rightButton")
    
    var isWalking: Bool = false
    
    override func sceneDidLoad() {
        print("Scene did load")
        print(UIScreen.main.bounds)
        init_nodes()
        
        addChild(background)
        addChild(bia)
        addChild(leftButton)
        addChild(rightButton)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.isEmpty { return }
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if leftButton.contains(location) {
            isWalking.toggle()
            if isWalking {
                print("Trying to walk backwards")
                bia.changeAnim(to: .walking, direction: .backward)
            } else {
                print("Trying to stop walking backwards")
                bia.changeAnim(to: .idle, direction: .backward)
            }
        } else if rightButton.contains(location) {
            isWalking.toggle()
            if isWalking {
                print("Trying to walk fowards")
                bia.changeAnim(to: .walking, direction: .foward)
            } else {
                print("Trying to stop walking fowards")
                bia.changeAnim(to: .idle, direction: .foward)
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        for touch in touches {
//            let location = touch.location(in: self)
//            
//            background.position.x = location.x
//        }
         
    }
    
    private func init_nodes() {
        background.position = .init(x: 429, y: 0)
        background.zPosition = 0
        
        bia.position = .init(x: -160, y: -80)
        bia.zPosition = 4
        
        leftButton.position = .init(x: -340, y: -120)
        rightButton.position = .init(x: -220, y: -120)
    }
}

