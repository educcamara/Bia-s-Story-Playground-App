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

    let playerNodes: [PlayerNode] = [
        .init(name: "bia"),
        .init(name: "rafa"),
        .init(name: "eliane"),
    ]
    
    let leftButton = PressButtonNode(name: "left_button")
    let rightButton = PressButtonNode(name: "right_button")
    let playButton = ToggleButtonNode(name: "play_button")
    
    override func sceneDidLoad() {
        init_nodes()
        
        addChild(background)
        addChild(backgroundSky)
        
        for player in playerNodes {addChild(player)}
        
        addChild(leftButton)
        addChild(rightButton)
        addChild(playButton)
    }

    override func update(_ currentTime: TimeInterval) {
        if background.position.x < -429 || background.position.x > 429 {
            background.stopMoving()
            for player in playerNodes {
                player.changeAnim(to: .idle, direction: player.direction)
            }
            
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
        
        playerNodes[0].position = .init(x: -115, y: -80)
        playerNodes[0].zPosition = 4
        
        playerNodes[1].position = .init(x: playerNodes[0].position.x - 75, y: playerNodes[0].position.y + 15)
        playerNodes[1].zPosition = playerNodes[0].zPosition - 0.2
        
        playerNodes[2].position = .init(x: playerNodes[1].position.x - 60, y: playerNodes[0].position.y - 10)
        playerNodes[2].zPosition = playerNodes[0].zPosition - 0.1
        
        leftButton.position = .init(x: -340, y: -120)
        leftButton.zPosition = 10
        rightButton.position = .init(x: 340, y: -120)
        rightButton.zPosition = 10
        
        playButton.position = .init(x: -340, y: 120)
        playButton.zPosition = 10
        
        leftButton.setStartTouchAction {
            for player in self.playerNodes {
                player.changeAnim(to: .walking, direction: .backward)
            }
            self.background.move(to: .backward)
        }
        leftButton.setEndTouchAction {
            for player in self.playerNodes {
                player.changeAnim(to: .idle, direction: .backward)
            }
            self.background.stopMoving()
        }
        rightButton.setStartTouchAction {
            for player in self.playerNodes {
                player.changeAnim(to: .walking, direction: .foward)
            }
            self.background.move(to: .foward)
        }
        rightButton.setEndTouchAction {
            for player in self.playerNodes {
                player.changeAnim(to: .idle, direction: .foward)
            }
            self.background.stopMoving()
        }
        
        playButton.toggleUserInteraction(to: false)
        playButton.setStartTouchAction {
            for player in self.playerNodes {
                player.changeAnim(to: .playing)
            }
            self.leftButton.toggleUserInteraction(to: false)
            self.rightButton.toggleUserInteraction(to: false)
        }
        playButton.setEndTouchAction {
            for player in self.playerNodes {
                player.changeAnim(to: .idle)
            }
            self.leftButton.toggleUserInteraction(to: true)
            self.rightButton.toggleUserInteraction(to: true)
        }
    }
}
