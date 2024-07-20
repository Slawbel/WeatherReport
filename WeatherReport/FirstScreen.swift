import UIKit

class FirstScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    private let weatherView = WeatherView()

    let weatherTypes: [WeatherAttributes] = [
        WeatherAttributes(name: "Fog", image: UIImage(systemName: "cloud.fog.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "fogAnimation"),
        WeatherAttributes(name: "Rain", image: UIImage(systemName: "cloud.rain.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "rainAnimation"),
        WeatherAttributes(name: "Hail", image: UIImage(systemName: "cloud.hail.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "hailAnimation"),
        WeatherAttributes(name: "Snow", image: UIImage(systemName: "cloud.snow.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "snowAnimation"),
        WeatherAttributes(name: "Windy", image: UIImage(systemName: "wind")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "windyAnimation"),
        WeatherAttributes(name: "Sunny", image: UIImage(systemName: "sun.max.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "sunnyAnimation"),
        WeatherAttributes(name: "Sleet", image: UIImage(systemName: "cloud.sleet.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "sleetAnimation"),
        WeatherAttributes(name: "Cloudy", image: UIImage(systemName: "cloud.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "cloudyAnimation"),
        WeatherAttributes(name: "Tornado", image: UIImage(systemName: "tornado")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "tornadoAnimation"),
        WeatherAttributes(name: "Drizzle", image: UIImage(systemName: "cloud.drizzle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "drizzleAnimation"),
        WeatherAttributes(name: "Blizzard", image: UIImage(systemName: "cloud.snow.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "blizzardAnimation"),
        WeatherAttributes(name: "Sandstorm", image: UIImage(systemName: "sun.dust.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "sandstormAnimation"),
        WeatherAttributes(name: "Thunderstorm", image: UIImage(systemName: "cloud.bolt.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "thunderstormAnimation"),
        WeatherAttributes(name: "Partly Cloudy", image: UIImage(systemName: "cloud.sun.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), animation: "partlyCloudyAnimation")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupWeatherView()
        setupCollectionView()
        displayRandomWeather()
    }

    private func setupWeatherView() {
        weatherView.frame = view.bounds
        weatherView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(weatherView)
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CellFirstScreen.self, forCellWithReuseIdentifier: "CellFirstScreen")

        setupCollectionViewConstraints()
    }

    private func displayRandomWeather() {
        let randomIndex = Int.random(in: 0..<weatherTypes.count)
        let randomWeather = weatherTypes[randomIndex]
        weatherView.showAnimation(named: randomWeather.animation)
    }

    private func transitionToWeather(_ newWeather: WeatherAttributes) {
        UIView.transition(with: weatherView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.weatherView.showAnimation(named: newWeather.animation)
        }, completion: nil)
    }

    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Horizontal scrolling

        let padding: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 4 // Number of items per row
        
        let collectionViewWidth = view.frame.width
        let totalPadding = padding * (numberOfItemsPerRow + 1)
        let itemWidth = (collectionViewWidth - totalPadding) / numberOfItemsPerRow
        
        let itemHeight = itemWidth // Ensure the itemHeight matches itemWidth (making them square)
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = padding // Spacing between items in a row
        layout.minimumLineSpacing = padding / 2 // Reduced spacing between lines
        
        return layout
    }

    private func setupCollectionViewConstraints() {
        // Calculate item size and number of rows
        let padding: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 4
        let numberOfRows = ceil(Double(weatherTypes.count) / Double(Int(numberOfItemsPerRow)))
        
        let collectionViewWidth = view.frame.width
        let totalPadding = padding * (numberOfItemsPerRow + 1)
        let itemWidth = (collectionViewWidth - totalPadding) / numberOfItemsPerRow
        let itemHeight = itemWidth
        
        // Calculate height for the collectionView to fit all cells
        let collectionViewHeight = min(CGFloat(numberOfRows) * (itemHeight + padding) + padding, view.frame.height * 0.15) // Limit height to 15% of the screen height
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellFirstScreen", for: indexPath) as? CellFirstScreen else {
            return UICollectionViewCell()
        }

        cell.weatherButton.setImage(weatherTypes[indexPath.item].image, for: .normal)
        cell.addActionClosure = { [weak self] in
            guard let self = self else { return }
            let selectedWeather = self.weatherTypes[indexPath.item]
            self.transitionToWeather(selectedWeather)
        }
        return cell
    }
}
