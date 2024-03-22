//
//  GameScene.swift
//  BiasStory
//
//  By Eduardo 10/03/24
//

import SpriteKit
import GameplayKit

// MARK: - Cena Principal
class GameScene: SKScene {
    let background = BackgroundNode(name: "background")
    let backgroundSky = BackgroundNode(name: "backgroundSky")

    let bia = PlayerNode(name: "bia")
    let rafa = PlayerNode(name: "rafa")
    let eliane = PlayerNode(name: "eliane")
    
    let leftButton = PressButtonNode(name: "left_button")
    let rightButton = PressButtonNode(name: "right_button")
    let playButton = ToggleButtonNode(name: "play_button")
    
    override func sceneDidLoad() {
        init_nodes()
        
        addChild(background)
        addChild(backgroundSky)
        
        addChild(bia)
        addChild(rafa)
        
        addChild(leftButton)
        addChild(rightButton)
        addChild(playButton)
    }

    override func update(_ currentTime: TimeInterval) {
        if background.position.x < -429 || background.position.x > 429 {
            background.stopMoving()
            bia.changeAnim(to: .idle, direction: bia.direction)
            rafa.changeAnim(to: .idle, direction: bia.direction)
            
            if background.position.x < 0 {
                background.reachedRightLimit = true
                playButton.toggleUserInteraction(to: true)
            }
            
            background.position.x += background.position.x < 0 ? 1 : -1
        }
        if background.position.x > -390 && background.reachedRightLimit {
            background.changeToSunsetBackground()
            backgroundSky.changeToSunsetBackground()
            playButton.toggleUserInteraction(to: false)
        }
    }
    
    private func init_nodes() {
        background.position = .init(x: 429, y: 0)
        background.zPosition = 0
        
        backgroundSky.position = .zero
        backgroundSky.zPosition = -1
        
        bia.position = .init(x: -150, y: -80)
        bia.zPosition = 4
        
        rafa.position = .init(x: bia.position.x - 65, y: bia.position.y + 15)
        rafa.zPosition = bia.zPosition - 0.1
        
        leftButton.position = .init(x: -340, y: -120)
        leftButton.zPosition = 10
        rightButton.position = .init(x: 340, y: -120)
        rightButton.zPosition = 10
        
        playButton.position = .init(x: -340, y: 120)
        playButton.zPosition = 10
        
        leftButton.setStartTouchAction {
            self.bia.changeAnim(to: .walking, direction: .backward)
            self.rafa.changeAnim(to: .walking, direction: .backward)
            self.background.move(to: .backward)
        }
        leftButton.setEndTouchAction {
            self.bia.changeAnim(to: .idle, direction: .backward)
            self.rafa.changeAnim(to: .idle, direction: .backward)
            self.background.stopMoving()
        }
        rightButton.setStartTouchAction {
            self.bia.changeAnim(to: .walking, direction: .foward)
            self.rafa.changeAnim(to: .walking, direction: .foward)
            self.background.move(to: .foward)
        }
        rightButton.setEndTouchAction {
            self.bia.changeAnim(to: .idle, direction: .foward)
            self.rafa.changeAnim(to: .idle, direction: .foward)
            self.background.stopMoving()
        }
        
        playButton.toggleUserInteraction(to: false)
        playButton.setStartTouchAction {
            self.bia.changeAnim(to: .playing)
            self.rafa.changeAnim(to: .playing)
            self.leftButton.toggleUserInteraction(to: false)
            self.rightButton.toggleUserInteraction(to: false)
        }
        playButton.setEndTouchAction {
            self.bia.changeAnim(to: .idle)
            self.rafa.changeAnim(to: .idle)
            self.leftButton.toggleUserInteraction(to: true)
            self.rightButton.toggleUserInteraction(to: true)
        }
    }
}
