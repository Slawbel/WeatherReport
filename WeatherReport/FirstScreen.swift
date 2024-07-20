import UIKit

class FirstScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!

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

        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CellFirstScreen.self, forCellWithReuseIdentifier: "CellFirstScreen")

        setupCollectionViewConstraints()
    }

    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Vertical scrolling
        
        // Number of items per row
        let numberOfItemsPerRow: CGFloat = CGFloat(weatherTypes.count / 2)
        let padding: CGFloat = 5
        let totalPadding = padding * (numberOfItemsPerRow + 1)
        let collectionViewWidth = view.frame.width
        let itemWidth = (collectionViewWidth - totalPadding) / numberOfItemsPerRow
        
        let collectionViewHeight = view.frame.height * 0.25
        let numberOfRows: CGFloat = 2
        let totalVerticalPadding = padding * (numberOfRows + 1)
        let itemHeight = (collectionViewHeight - totalVerticalPadding) / numberOfRows
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        return layout
    }

    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)
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
            self?.handleWeatherButtonTap(at: indexPath)
        }
        return cell
    }

    private func handleWeatherButtonTap(at indexPath: IndexPath) {
        let animationName = weatherTypes[indexPath.item].animation
        showAnimation(for: animationName)
    }

    private func showAnimation(for animationName: String) {
        // Implement animation logic here
        print("Showing animation: \(animationName)")
    }
}
