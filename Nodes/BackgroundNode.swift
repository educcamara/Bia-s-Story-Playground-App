//
//  File.swift
//  
//
//  Created by Eduardo Cordeiro da Camara on 11/03/24.
//

import Foundation
import SpriteKit

class BackgroundNode: SKNode {
    var sprite: SKSpriteNode
    
    init(name: String) {
        print("init started \(name)")
        sprite = .init(imageNamed: "\(name)_1")
        sprite.name = name
        super.init()

        // Idle Animation
        addChild(sprite)
        let ratio = UIScreen.main.bounds.height/sprite.size.height
        sprite.size.height = UIScreen.main.bounds.height
        sprite.size.width = sprite.size.width * ratio
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}
