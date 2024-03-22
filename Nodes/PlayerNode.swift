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
    case idle, walking, playing
}

enum Directions {
    case foward, backward
}

/// Classe que representa o nó de um jogador no jogo.
class PlayerNode: SKNode {
    /// Sprite que representa o personagem do jogador. É a ele que atribuímos um  asset, configurações como escala, animação, assim por diante.
    var sprite: SKSpriteNode
    /// A direção atual para onde  o jogador está voltado.
    var cropNode: SKCropNode
    
    
    var direction: Directions
    /// A animação atual em que nosso Player está.
    var currentAnimState: AnimStates
    
    /// Init de uma classe/struct é muito importante para configurar certos dados dentro dela. É ela que é chamada assim que atribuímos uma variável ou constante à classe.
    /// - Parameter name: Ele recebe o nome do prefixo de seus assets, por exemplo "bia\_idle\_1", "bia\_idle\_2", "bia\_walking\_1"... então o `name` será "bia".
    init(name: String) {
        sprite = .init(imageNamed: "\(name)_idle_1")
        sprite.name = name
        
        cropNode = .init()
        
        direction = .foward
        currentAnimState = .playing
        
        super.init()
        self.name = name
        
        let idleAnimation = getIdleAnimation(prefix: name)
        
        
        sprite.scale(to: .init(width: 150, height: 150))
        sprite.run(.repeatForever(idleAnimation))
        
        cropNode.maskNode = sprite
        cropNode.run(.repeatForever(idleAnimation))
        
        cropNode.addChild(sprite)
        addChild(cropNode)
    }
    
    private func getIdleAnimation(prefix: String) -> SKAction {
        var playerTextures: [SKTexture] = []
        
        for index in 1...6 {
            let textureName = "\(prefix)_idle_\(index)"
            let texture = SKTexture(imageNamed: textureName)
            
            playerTextures.append(texture)
            // Append texture again based on certain conditions
            if index < 6 && index > 1 {playerTextures.append(texture)}
            if index == 3 {playerTextures.append(texture)}
        }
        let randomTimePerFrame: CGFloat = .random(in: (0.06)...(0.08))
        let idleAnimation = SKAction.animate(with: playerTextures, timePerFrame: randomTimePerFrame)
        return idleAnimation
    }
    
    private func getWalkingAnimation(prefix: String) -> SKAction {
        var playerTextures: [SKTexture] = []
        
        for index in 1...8 {
            let textureName = "\(prefix)_walking_\(index)"
            
            let texture = SKTexture(imageNamed: textureName)
            playerTextures.append(texture)
        }
        let randomTimePerFrame: CGFloat = .random(in: (0.07)...(0.09))
        let walkingAnimation = SKAction.animate(with: playerTextures, timePerFrame: randomTimePerFrame)
        
        return walkingAnimation
    }
    
    private func getPlayingAnimation(prefix: String) -> SKAction {
        var playerTextures: [SKTexture] = []
        
        for index in 1...13 {
            let textureName = "\(prefix)_playing_\(index)"
            
            let texture = SKTexture(imageNamed: textureName)
            playerTextures.append(texture)
        }
        let randomTimePerFrame: CGFloat = .random(in: (0.10)...(0.12))
        let playingAnimation = SKAction.animate(with: playerTextures, timePerFrame: randomTimePerFrame)
        
        return playingAnimation
    }
    
    public func changeAnim(to value: AnimStates, direction: Directions? = nil) {
        sprite.removeAllActions()
        if direction != nil {
            setDirection(direction: direction!)
        }
        
        switch value {
        case .idle:
            currentAnimState = .idle
            
            let idleAnimation = getIdleAnimation(prefix: self.name!)
            self.sprite.run(.repeatForever(idleAnimation))
        case .walking:
            currentAnimState = .walking
            
            let walkingAnimation = getWalkingAnimation(prefix: self.name!)
            self.sprite.run(.repeatForever(walkingAnimation))
        case .playing:
            currentAnimState = .playing
            
            let playingAnimation = getPlayingAnimation(prefix: self.name!)
            self.sprite.run(.repeatForever(playingAnimation))
        }
    }
    
    private func setDirection(direction: Directions) {
        switch direction {
        case .foward:
            if self.direction == .backward {
                self.sprite.size.width *= -1
                self.direction = .foward
            }
        case .backward:
            if self.direction == .foward {
                self.sprite.size.width *= -1
                self.direction = .backward
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
