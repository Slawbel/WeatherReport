
import UIKit

class FirstScreen: UIViewController {
    let segmentedControl = UISegmentedControl()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControlSettings()
    }
    
    internal func setupSegmentedControlSettings() {
        //segmentedControl.numberOfSegments = 2
        segmentedControl.backgroundColor = .lightGray
        //segmentedControl.addTarget(self, action: <#T##Selector#>, for: .valueChanged)
    }
    
}

