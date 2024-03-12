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
    let leftButton = ButtonNode(name: "left_button")
    let rightButton = ButtonNode(name: "right_button")
    
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
        
        if !isWalking {
            isWalking.toggle()
            if leftButton.contains(location) {
                print("Trying to walk backwards")
                leftButton.isBeingTouched = true
                leftButton.toggleTouchState()
                bia.changeAnim(to: .walking, direction: .backward)
                
                background.removeAllActions()
                background.run(.repeatForever(.move(by: .init(dx: 2, dy: 0), duration: 0.01)))
            } else if rightButton.contains(location) {
                print("Trying to walk fowards")
                rightButton.isBeingTouched = true
                rightButton.toggleTouchState()
                bia.changeAnim(to: .walking, direction: .foward)
                
                background.removeAllActions()
                background.run(.repeatForever(.move(by: .init(dx: -2, dy: 0), duration: 0.01)))
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.isEmpty { return }
        
        if leftButton.isBeingTouched {
            leftButton.isBeingTouched = false
            leftButton.toggleTouchState()
        } else if rightButton.isBeingTouched {
            rightButton.isBeingTouched = false
            rightButton.toggleTouchState()
        }
        
        if isWalking {
            isWalking.toggle()
            print("Trying to stop walking")
            bia.changeAnim(to: .idle, direction: bia.direction)
            background.removeAllActions()
            
            //background.fadeIn(duration: 2)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if background.position.x < -429 || background.position.x > 429 {
            isWalking = false
            
            background.removeAllActions()
            bia.changeAnim(to: .idle, direction: bia.direction)
            
            if background.position.x < 0 {
                background.position.x += 1
            } else {
                background.position.x -= 1
            }
        }
    }
    
    private func init_nodes() {
        background.position = .init(x: 429, y: 0)
        background.zPosition = 0
        
        bia.position = .init(x: -160, y: -80)
        bia.zPosition = 4
        
        leftButton.position = .init(x: -340, y: -120)
        rightButton.position = .init(x: 340, y: -120)
    }
}

