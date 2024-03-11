//
//  File.swift
//  
//
//  Created by Eduardo Cordeiro da Camara on 11/03/24.
//

import Foundation
import SpriteKit

enum Directions {
    case foward, backward
}

class ButtonNode: SKNode {
    let sprite: SKSpriteNode
    
    init(name: String, direction: Directions) {
        sprite = .init(color: .init(red: 0.5, green: 0.6, blue: 0.6, alpha: 0.6), size: .init(width: 100, height: 100))
        
        super.init()
        self.name = name
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
