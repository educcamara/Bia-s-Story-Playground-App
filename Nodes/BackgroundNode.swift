//
//  File.swift
//  
//
//  Created by Eduardo Cordeiro da Camara on 11/03/24.
//

import Foundation
import SpriteKit

class BackgroundNode: SKNode {
    let sprite: SKSpriteNode
//    let spriteForeground: SKSpriteNode
    
    init(name: String) {
        print("init started \(name)")
        sprite = .init(imageNamed: "\(name)_1")
        sprite.name = name
        
        
        let ratio = UIScreen.main.bounds.height/sprite.size.height
        sprite.size.height = UIScreen.main.bounds.height
        sprite.size.width = sprite.size.width * ratio
        
//        spriteForeground = .init(
//            color: .blue,
//            size: .init(width: sprite.size.width, height: sprite.size.height))
//        spriteForeground.alpha = 0
//        spriteForeground.blendMode = .multiply
//        spriteForeground.zPosition = 5
        
        super.init()
        
        addChild(sprite)
//        addChild(spriteForeground)
    }
    
//    public func fadeIn(duration: TimeInterval) {
//        spriteForeground.run(.fadeIn(withDuration: duration))
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}
