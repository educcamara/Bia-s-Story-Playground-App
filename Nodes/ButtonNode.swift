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
    
    var startTouchAction: (() -> Void)?
    var endTouchAction: (() -> Void)?
    
    init(name: String) {
        sprite = .init(imageNamed: "\(name)")
        sprite.scale(to: .init(width: 100, height: 100))
        sprite.alpha = 0.6
        isBeingTouched = false
        
        super.init()
        self.name = name
        isUserInteractionEnabled = true
        
        self.addChild(sprite)
    }
    
    public func setStartTouchAction(action: @escaping () -> Void) {
        startTouchAction = action
    }
    
    public func setEndTouchAction(action: @escaping () -> Void) {
        endTouchAction = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isBeingTouched = true
        
        let scaleOut:SKAction = .group([
            .scale(by: 1.1, duration: 0.05),
            .fadeAlpha(to: 0.8, duration: 0.05)
        ])
        sprite.run(scaleOut)
        self.startTouchAction?()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isBeingTouched = false
        
        let scaleIn: SKAction = .group([
            .scale(to: .init(width: 100, height: 100), duration: 0.05),
            .fadeAlpha(to: 0.6, duration: 0.05)
        ])
        sprite.run(scaleIn)
        self.endTouchAction?()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
