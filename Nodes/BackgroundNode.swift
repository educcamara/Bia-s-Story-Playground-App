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
    
    init(name: String) {
        print("init started \(name)")
        sprite = .init(imageNamed: "\(name)_1")
        sprite.name = name
        
        
        let ratio = UIScreen.main.bounds.height/sprite.size.height
        sprite.size.height = UIScreen.main.bounds.height
        sprite.size.width = sprite.size.width * ratio
        
        super.init()
        
        addChild(sprite)
    }
    
    public func move(to direction: Directions) {
        self.removeAllActions()
        let velocity: CGFloat = direction == .backward ? 2 : -2
        self.run(.repeatForever(.move(by: .init(dx: velocity, dy: 0), duration: 0.01)))
    }
    
    public func stopMoving() {
        self.removeAllActions()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}
