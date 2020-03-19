import UIKit
import SwiftUI

final class Scene: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    private let news = News()
    
    func scene(_ scene: UIScene, willConnectTo: UISceneSession, options: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            window.rootViewController = UIHostingController(rootView: Articles(news: news))
            window.makeKeyAndVisible()
            self.window = window
        }
    }
    
    func sceneDidBecomeActive(_: UIScene) {
        news.refresh()
    }
}
