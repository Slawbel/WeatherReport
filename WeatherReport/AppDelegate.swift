import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    // Called when the application has finished launching
    // Parameters: application: The singleton app object; launchOptions: A dictionary indicating the reason the app was launched (if any)
    // Returns: A boolean value indicating whether the app successfully handled the launch request
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Initialize the main window with the screen's bounds
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Set the root view controller of the window to an instance of FirstScreen
        window?.rootViewController = FirstScreen()
        window?.makeKeyAndVisible()
        
        return true
    }

}

