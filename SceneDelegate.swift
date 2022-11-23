//
//  SceneDelegate.swift
//  openweatherapp
//
//  Created by berat can beduk on 22.11.2022.
//

import UIKit
var myApikeyFromSceneDelegate : String?
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let firstViewController : FirstViewController = FirstViewController()
    var weatherManager = WeatherManager.sharedInstance
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    // Set up for deeplinking and reaching the api key from link
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url{
            print(url)
            let urlString = url.absoluteString
            let component = urlString.components(separatedBy: "=")
            
            if component.count > 1 , let apikey = component.last{
              /*  if(apikey == "8ddadecc7ae4f56fee73b2b405a63659"){
                    NavigateToViewController(apikey: apikey)
                }*/
                print("my api key : \(apikey) ")
                myApikeyFromSceneDelegate = apikey 
                NavigateToViewController()
            }
        }
    }
    // Navigate directly to the weather scene with apikey
    func NavigateToViewController(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let targetVC = storyboard.instantiateViewController(withIdentifier: "secondViewController") as? ViewController else{return}
        let navVc = self.window?.rootViewController as? UINavigationController
    
        navVc?.pushViewController(targetVC, animated: true)
        
    }

}

