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
    let backgroundSky = BackgroundNode(name: "backgroundSky")
    let bia = PlayerNode(name: "bia")
    let leftButton = ButtonNode(name: "left_button")
    let rightButton = ButtonNode(name: "right_button")
    let playButton = ToggleButtonNode(name: "right_button") // #TEMPORARY
    
    override func sceneDidLoad() {
        print("Scene did load")
        print(UIScreen.main.bounds)
        init_nodes()
        
        addChild(background)
        addChild(backgroundSky)
        addChild(bia)
        addChild(leftButton)
        addChild(rightButton)
        addChild(playButton)
    }

    override func update(_ currentTime: TimeInterval) {
        if background.position.x < -429 || background.position.x > 429 {
            background.stopMoving()
            bia.changeAnim(to: .idle, direction: bia.direction)
            
            if background.position.x < 0 {
                background.reachedRightLimit = true
            }
            
            background.position.x += background.position.x < 0 ? 1 : -1
        }
        if background.position.x > -390 && background.reachedRightLimit {
            background.changeToSunsetBackground()
            backgroundSky.changeToSunsetBackground()
        }
    }
    
    private func init_nodes() {
        background.position = .init(x: 429, y: 0)
        background.zPosition = 0
        
        backgroundSky.position = .zero
        backgroundSky.zPosition = -1
        
        bia.position = .init(x: -160, y: -80)
        bia.zPosition = 4
        
        leftButton.position = .init(x: -340, y: -120)
        leftButton.zPosition = 10
        rightButton.position = .init(x: 340, y: -120)
        rightButton.zPosition = 10
        
        playButton.position = .init(x: -340, y: 120)
        playButton.zPosition = 10
        
        leftButton.setStartTouchAction {
            self.bia.changeAnim(to: .walking, direction: .backward)
            self.background.move(to: .backward)
        }
        leftButton.setEndTouchAction {
            self.bia.changeAnim(to: .idle, direction: .backward)
            self.background.stopMoving()
        }
        rightButton.setStartTouchAction {
            self.bia.changeAnim(to: .walking, direction: .foward)
            self.background.move(to: .foward)
        }
        rightButton.setEndTouchAction {
            self.bia.changeAnim(to: .idle, direction: .foward)
            self.background.stopMoving()
        }
        
        playButton.setStartTouchAction {
            self.bia.togglePlayingAnim(to: true)
            self.leftButton.toggleUserInteraction(to: false)
            self.rightButton.toggleUserInteraction(to: false)
        }
        playButton.setEndTouchAction {
            self.bia.togglePlayingAnim(to: false)
            self.leftButton.toggleUserInteraction(to: true)
            self.rightButton.toggleUserInteraction(to: true)
        }
    }
}

