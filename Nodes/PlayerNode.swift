//
//  BiaNode.swift
//  BiasStory
//
//  Created by Eduardo Cordeiro da Camara on 10/03/24.
//

import Foundation
import SpriteKit
import GameplayKit

enum AnimStates {
    case idle, walk
}

class PlayerNode: SKNode {
    var sprite: SKSpriteNode
    
    init(name: String) {
        print("init started \(name)_idle_1")
        sprite = .init(imageNamed: "\(name)_idle_1")
        sprite.name = name
        super.init()
        self.name = name
        
        let idleAnimation = getIdleAnimation(prefix: name)

        // Idle Animation
        sprite.run(.repeatForever(idleAnimation))
        sprite.scale(to: .init(width: 140, height: 140))
        addChild(sprite)
        
        //sprite.size.width *= -1
    }
    
    private func getIdleAnimation(prefix: String) -> SKAction {
        var playerTextures: [SKTexture] = []
        
        for index in 1...5 {
            let textureName = "\(prefix)_idle_\(index)"
            //print("\(textureName)")
            let texture = SKTexture(imageNamed: textureName)
            
            playerTextures.append(texture)
            
            // Append texture again based on certain conditions
            if index < 5 {
                playerTextures.append(texture)
            }
            if index == 2 {
                playerTextures.append(texture)
            }
        }
        let idleAnimation = SKAction.animate(with: playerTextures, timePerFrame: 0.07)
        return idleAnimation
    }
    
    private func getWalkingAnimation(prefix: String) -> SKAction {
        var playerTextures: [SKTexture] = []
        
        for index in 1...8 {
            let textureName = "\(prefix)_walking_\(index)"
            
            let texture = SKTexture(imageNamed: textureName)
            playerTextures.append(texture)
        }
        let walkingAnimation = SKAction.animate(with: playerTextures, timePerFrame: 1/12)
        
        return walkingAnimation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeAnim(_ value: AnimStates) {
        sprite.removeAllActions()
        
        switch value {
        case .idle:
            let idleAnimation = getIdleAnimation(prefix: self.name!)
            self.sprite.run(.repeatForever(idleAnimation))
        case .walk:
            let walkingAnimation = getWalkingAnimation(prefix: self.name!)
            self.sprite.run(.repeatForever(walkingAnimation))
        }
    }
}
