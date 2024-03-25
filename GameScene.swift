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
    
    let npcNodes: [PlayerNode] = [
        .init(name: "npc1"),
        .init(name: "npc2")
    ]
    
    let leftButton = PressButtonNode(name: "left_button")
    let rightButton = PressButtonNode(name: "right_button")
    let playButton = ToggleButtonNode(name: "play_button")
    
    var alreadyPlayed = false
    
    override func sceneDidLoad() {
        init_nodes()
        
        addChild(background)
        addChild(backgroundSky)
        
        for player in playerNodes {addChild(player)}
        for npc in npcNodes {addChild(npc)}
        
        addChild(leftButton)
        addChild(rightButton)
        addChild(playButton)
        
        for player in playerNodes {
            player.moveBy(vector: .init(dx: 355, dy: 0))
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if background.position.x < -429 || background.position.x > 429 {
            background.stopMoving()
            background.position.x += background.position.x < 0 ? 2 : -2
            
            for player in playerNodes {
                player.changeAnim(to: .idle, direction: player.direction)
            }
            
            if background.position.x < 0 && background.reachedRightLimit == false {
                background.reachedRightLimit = true
                playButton.toggleUserInteraction(to: true)
                
                for npc in npcNodes {
                    npc.moveBy(vector: .init(dx: -335, dy: 0))
                }
            }
        }
        if background.position.x > -400 && background.reachedRightLimit {
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
        
        playerNodes[0].position = .init(x: -450, y: -80)
        playerNodes[0].zPosition = 4
        
        playerNodes[1].position = .init(x: playerNodes[0].position.x - 75, y: playerNodes[0].position.y + 15)
        playerNodes[1].zPosition = playerNodes[0].zPosition - 0.2
        
        playerNodes[2].position = .init(x: playerNodes[1].position.x - 60, y: playerNodes[0].position.y - 10)
        playerNodes[2].zPosition = playerNodes[0].zPosition - 0.1
        
        
        npcNodes[0].position = .init(x: 490, y: -70)
        npcNodes[0].zPosition = 4
        
        npcNodes[1].position = .init(x: npcNodes[0].position.x + 75, y: npcNodes[0].position.y - 15)
        npcNodes[1].zPosition = npcNodes[0].zPosition + 1
        
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
            for npc in self.npcNodes {
                npc.changeAnim(to: .playing)
            }
            self.leftButton.toggleUserInteraction(to: false)
            self.rightButton.toggleUserInteraction(to: false)
        }
        playButton.setEndTouchAction {
            if !self.alreadyPlayed {
                self.run(.sequence([
                    .wait(forDuration: 1),
                    .run {
                        for npc in self.npcNodes {
                            npc.moveBy(vector: .init(dx: 355, dy: 0))
                        }
                        self.leftButton.toggleUserInteraction(to: true)
                        self.rightButton.toggleUserInteraction(to: true)
                        self.alreadyPlayed = true
                    }
                ]))
            } else {
                self.leftButton.toggleUserInteraction(to: true)
                self.rightButton.toggleUserInteraction(to: true)
                self.alreadyPlayed = true
            }
            for player in self.playerNodes {
                player.changeAnim(to: .idle)
            }
            for npc in self.npcNodes {
                npc.changeAnim(to: .idle)
            }
            

        }
    }
}
