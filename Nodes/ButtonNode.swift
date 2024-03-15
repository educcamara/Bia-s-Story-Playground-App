//
//  File.swift
//  
//
//  Created by Eduardo Cordeiro da Camara on 11/03/24.
//

import Foundation
import SpriteKit

class ButtonNode: SKNode {
    public let sprite: SKSpriteNode
    
    public var isBeingTouched: Bool
    
    private var startTouchAction: (() -> Void)?
    private var endTouchAction: (() -> Void)?
    
    var scaleInAnimation: SKAction {
    get {.group([
            .scale(to: .init(width: 100, height: 100), duration: 0.05),
            .fadeAlpha(to: 0.6, duration: 0.05)
    ])}
}
    var scaleOutAnimation: SKAction {
    get {.group([
            .scale(by: 1.1, duration: 0.05),
            .fadeAlpha(to: 0.8, duration: 0.05)
        ])
    }
}
    
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
    
    public func toggleUserInteraction(to value: Bool? = nil) {
        isUserInteractionEnabled = value ?? !isUserInteractionEnabled
        if isUserInteractionEnabled {
            sprite.alpha = 0.6
        } else {
            sprite.alpha = 0.3
        }
    }
    
    public func setStartTouchAction(action: @escaping () -> Void) {
        startTouchAction = action
    }
    
    public func setEndTouchAction(action: @escaping () -> Void) {
        endTouchAction = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isBeingTouched = true
        
        sprite.run(scaleOutAnimation)
        self.startTouchAction?()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isBeingTouched = false
        
        sprite.run(scaleInAnimation)
        self.endTouchAction?()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ToggleButtonNode: ButtonNode {
    public var didTouch: Bool
    
    private var startTouchAction: (() -> Void)?
    private var endTouchAction: (() -> Void)?
    
    override init(name: String) {
        didTouch = false
        super.init(name: name)
    }
    
    override func setStartTouchAction(action: @escaping () -> Void) {
        startTouchAction = action
    }
    override func setEndTouchAction(action: @escaping () -> Void) {
        endTouchAction = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isBeingTouched = true
        didTouch.toggle()
        
        if didTouch {
            sprite.run(super.scaleOutAnimation)
            self.startTouchAction?()
        } else {
            sprite.run(super.scaleInAnimation)
            self.endTouchAction?()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isBeingTouched = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
