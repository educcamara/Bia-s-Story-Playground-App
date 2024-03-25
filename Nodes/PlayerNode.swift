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
    
    private var spriteShadow: SKShapeNode
    private var spriteMud: SKSpriteNode
    
    
    var direction: Directions
    /// A animação atual em que nosso Player está.
    var currentAnimState: AnimStates
    
    private var isMovingBy: Bool = false
    
    private var randomIdleTimePerFrame: CGFloat
    private var randomWalkingTimePerFrame: CGFloat
    private var randomPlayingTimePerFrame: CGFloat
    
    /// Init de uma classe/struct é muito importante para configurar certos dados dentro dela. É ela que é chamada assim que atribuímos uma variável ou constante à classe.
    /// - Parameter name: Ele recebe o nome do prefixo de seus assets, por exemplo "bia\_idle\_1", "bia\_idle\_2", "bia\_walking\_1"... então o `name` será "bia".
    init(name: String) {
        sprite = .init(imageNamed: "\(name)_idle_1")
        sprite.name = name
        
        cropNode = .init()
        spriteShadow = .init(ellipseIn: .init(x: sprite.position.x - 28, y: sprite.position.y - 70, width: 65, height: 25))
        spriteShadow.strokeColor = .clear
        spriteShadow.fillColor = .black
        spriteShadow.alpha = 0.3
        spriteShadow.zPosition = sprite.zPosition - 0.01
        
        spriteMud = .init(imageNamed: "mud_idle_1")
        spriteMud.alpha = 0.8
        spriteMud.blendMode = .multiplyAlpha
        spriteMud.zPosition = sprite.zPosition + 0.01
        
        direction = .foward
        currentAnimState = .idle
        
        randomIdleTimePerFrame = .random(in: (0.06)...(0.08))
        randomWalkingTimePerFrame = .random(in: (0.07)...(0.09))
        randomPlayingTimePerFrame = .random(in: (0.10)...(0.12))
        
        super.init()
        self.name = name
        
        let idleAnimation = getIdleAnimation(prefix: name)
        let idleMudAnimation = getIdleAnimation(prefix: "mud")
        
        
        sprite.scale(to: .init(width: 150, height: 150))
        sprite.run(.repeatForever(idleAnimation))
        
        cropNode.maskNode = sprite
        cropNode.run(.repeatForever(idleAnimation))
        
        spriteMud.scale(to: .init(width: 150, height: 150))
        spriteMud.run(.repeatForever(idleMudAnimation))
        
        cropNode.addChild(sprite)
        cropNode.addChild(spriteMud)
        addChild(cropNode)
        addChild(spriteShadow)
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
        
        let idleAnimation = SKAction.animate(with: playerTextures, timePerFrame: randomIdleTimePerFrame)
        return idleAnimation
    }
    
    private func getWalkingAnimation(prefix: String) -> SKAction {
        var playerTextures: [SKTexture] = []
        
        for index in 1...8 {
            let textureName = "\(prefix)_walking_\(index)"
            
            let texture = SKTexture(imageNamed: textureName)
            playerTextures.append(texture)
        }
        
        let walkingAnimation = SKAction.animate(with: playerTextures, timePerFrame: randomWalkingTimePerFrame)
        
        return walkingAnimation
    }
    
    private func getPlayingAnimation(prefix: String) -> SKAction {
        var playerTextures: [SKTexture] = []
        
        for index in 1...13 {
            let textureName = "\(prefix)_playing_\(index)"
            
            let texture = SKTexture(imageNamed: textureName)
            playerTextures.append(texture)
        }
        
        let playingAnimation = SKAction.animate(with: playerTextures, timePerFrame: randomPlayingTimePerFrame)
        
        return playingAnimation
    }
    
    public func changeAnim(to value: AnimStates, direction: Directions? = nil) {
        if isMovingBy {return}
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
    
    public func moveBy(vector: CGVector) {
        let direction: Directions = vector.dx > 0 ? .foward : .backward
        let duration: CGFloat = abs(vector.dx)/2 * 0.015
        
        changeAnim(to: .walking, direction: direction)
        
        isMovingBy = true
        self.run(.group([
            .move(by: vector, duration: duration),
            .sequence([
                .wait(forDuration: duration + 0.01),
                .run {
                    self.isMovingBy.toggle()
                    self.changeAnim(to: .idle)
                }
            ])
        ]))
    }
    
    public func setDirection(direction: Directions) {
        switch direction {
        case .foward:
            if self.direction == .backward {
                self.sprite.size.width *= -1
                self.spriteMud.size.width *= -1
                self.spriteShadow.position.x += 9
                self.direction = .foward
            }
        case .backward:
            if self.direction == .foward {
                self.sprite.size.width *= -1
                self.spriteMud.size.width *= -1
                self.spriteShadow.position.x -= 9
                self.direction = .backward
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
