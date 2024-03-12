//
//  File.swift
//  
//
//  Created by Eduardo Cordeiro da Camara on 11/03/24.
//

import Foundation
import SpriteKit

class ButtonNode: SKNode {
    let sprite: SKSpriteNode
    var isBeingTouched: Bool
    
    var action: (() -> Void)?
    var didEndTouch: (() -> Void)?
    
    init(name: String, action: (() -> Void)? = nil, end: (() -> Void)? = nil) {
        sprite = .init(imageNamed: "\(name)")
        sprite.scale(to: .init(width: 100, height: 100))
        sprite.alpha = 0.6
        
        isBeingTouched = false
        
        self.action = action
        self.didEndTouch = end
        
        super.init()
        self.name = name
        self.addChild(sprite)
        
        //isUserInteractionEnabled = true
    }
    
    public func toggleTouchState() {
        if isBeingTouched {
            let scaleOut:SKAction = .group([
                .scale(by: 1.1, duration: 0.05),
                .fadeAlpha(to: 0.8, duration: 0.05)
            ])
            
            sprite.run(scaleOut)
        } else {
            let scaleIn: SKAction = .group([
                .scale(to: .init(width: 100, height: 100), duration: 0.05),
                .fadeAlpha(to: 0.6, duration: 0.05)
            ])
            
            sprite.run(scaleIn)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let scaleOut = SKAction.scale(by: 1.1, duration: 0.05)
//        sprite.run(scaleOut)
//        self.action?()
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let scaleIn = SKAction.scale(to: .init(width: 100, height: 100), duration: 0.05)
//        
//        sprite.run(scaleIn)
//        self.didEndTouch?()
//    }
}
