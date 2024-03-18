//
//  File.swift
//  
//
//  Created by Eduardo Cordeiro da Camara on 11/03/24.
//

import Foundation
import SpriteKit

class BackgroundNode: SKNode {
    let spriteDay: SKSpriteNode
    let spriteSunset: SKSpriteNode
    
    var reachedRightLimit: Bool = false
    
    init(name: String) {
        spriteDay = .init(imageNamed: "\(name)_day")
        spriteDay.name = "\(name)_day"
        spriteDay.zPosition = 0
        
        spriteSunset = .init(imageNamed: "\(name)_sunset")
        spriteSunset.name = "\(name)_sunset"
        spriteSunset.alpha = 0
        spriteSunset.zPosition = 0.1
        
        let ratio = UIScreen.main.bounds.height/spriteDay.size.height
        spriteDay.size.height = UIScreen.main.bounds.height
        spriteDay.size.width *= ratio
        spriteSunset.size.height = UIScreen.main.bounds.height
        spriteSunset.size.width *= ratio
        
        super.init()
        
        addChild(spriteDay)
        addChild(spriteSunset)
    }
    
    public func move(to direction: Directions) {
        self.removeAllActions()
        let velocity: CGFloat = direction == .backward ? 2 : -2
        self.run(.repeatForever(.move(by: .init(dx: velocity, dy: 0), duration: 0.01)))
    }
    
    public func stopMoving() {
        self.removeAllActions()
    }
    
    public func changeToSunsetBackground() {
        spriteSunset.run(.fadeIn(withDuration: 3))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
