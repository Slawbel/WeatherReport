
import UIKit

class FirstScreen: UIViewController {
    let segmentedControl = UISegmentedControl()
    
    let weatherTypes: [WeatherAttributes] = [
        WeatherAttributes(name: "Fog", image: UIImage(named: "fog")!, animation: "fogAnimation"),
        WeatherAttributes(name: "Rain", image: UIImage(named: "rain")!, animation: "rainAnimation"),
        WeatherAttributes(name: "Hail", image: UIImage(named: "hail")!, animation: "hailAnimation"),
        WeatherAttributes(name: "Snow", image: UIImage(named: "snow")!, animation: "snowAnimation"),
        WeatherAttributes(name: "Windy", image: UIImage(named: "windy")!, animation: "windyAnimation"),
        WeatherAttributes(name: "Sunny", image: UIImage(named: "sunny")!, animation: "sunnyAnimation"),
        WeatherAttributes(name: "Sleet", image: UIImage(named: "sleet")!, animation: "sleetAnimation"),
        WeatherAttributes(name: "Cloudy", image: UIImage(named: "cloudy")!, animation: "cloudyAnimation"),
        WeatherAttributes(name: "Tornado", image: UIImage(named: "tornado")!, animation: "tornadoAnimation"),
        WeatherAttributes(name: "Drizzle", image: UIImage(named: "drizzle")!, animation: "drizzleAnimation"),
        WeatherAttributes(name: "Blizzard", image: UIImage(named: "blizzard")!, animation: "blizardAnimation"),
        WeatherAttributes(name: "Sandstorm", image: UIImage(named: "sandstorm")!, animation: "sandstormAnimation"),
        WeatherAttributes(name: "Thunderstorm", image: UIImage(named: "thunderstorm")!, animation: "thunderstormAnimation"),
        WeatherAttributes(name: "Partly Cloudy", image: UIImage(named: "partly_cloudy")!, animation: "partlyCloudyAnimation")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControlConstraints()
        setupSegmentedControlSettings()
    }
    
    internal func setupSegmentedControlConstraints() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    internal func setupSegmentedControlSettings() {
        for (index, weatherType) in weatherTypes.enumerated() {
            segmentedControl.insertSegment(with: weatherTypes[index].image, at: index, animated: false)
        }
        
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
    }
    
}

