import SwiftUI
import SpriteKit

struct ContentView: View {
    var forceLandscape: Bool = false
    
    var scene: GameScene {
        
        let scene = GameScene(size: .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
        //            .onAppear {
        //                let currentOrientation = UIDevice.current.orientation
        //                if currentOrientation == .landscapeLeft
        //                    || currentOrientation == .landscapeRight {
        //                    UIDevice.current.setValue(currentOrientation.rawValue, forKey: "orientation")
        //                } else {
        //                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        //                }
        //                UINavigationController.attemptRotationToDeviceOrientation()
        //            }
    }
}
