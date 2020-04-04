import UIKit
import SwiftUI

final class Scene: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo: UISceneSession, options: UIScene.ConnectionOptions) {
        UINavigationBar.appearance().tintColor = UIColor(named: "lightning")!
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "lightning")!
        UISwitch.appearance().onTintColor = UIColor(named: "lightning")!
        let window = UIWindow(windowScene: scene as! UIWindowScene)
        window.rootViewController = UIHostingController(rootView: {
            switch $0 {
            case .pad: return .init(Split())
            default: return .init(Articles())
            }
        } (UIDevice.current.userInterfaceIdiom) as AnyView)
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func sceneDidBecomeActive(_: UIScene) {
        news.refresh()
    }
}
