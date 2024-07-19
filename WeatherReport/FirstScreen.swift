import UIKit

class FirstScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!

    let weatherTypes: [WeatherAttributes] = [
        WeatherAttributes(name: "Fog", image: UIImage(named: "fog") ?? UIImage(), animation: "fogAnimation"),
        WeatherAttributes(name: "Rain", image: UIImage(named: "rain") ?? UIImage(), animation: "rainAnimation"),
        WeatherAttributes(name: "Hail", image: UIImage(named: "hail") ?? UIImage(), animation: "hailAnimation"),
        WeatherAttributes(name: "Snow", image: UIImage(named: "snow") ?? UIImage(), animation: "snowAnimation"),
        WeatherAttributes(name: "Windy", image: UIImage(named: "windy") ?? UIImage(), animation: "windyAnimation"),
        WeatherAttributes(name: "Sunny", image: UIImage(named: "sunny") ?? UIImage(), animation: "sunnyAnimation"),
        WeatherAttributes(name: "Sleet", image: UIImage(named: "sleet") ?? UIImage(), animation: "sleetAnimation"),
        WeatherAttributes(name: "Cloudy", image: UIImage(named: "cloudy") ?? UIImage(), animation: "cloudyAnimation"),
        WeatherAttributes(name: "Tornado", image: UIImage(named: "tornado") ?? UIImage(), animation: "tornadoAnimation"),
        WeatherAttributes(name: "Drizzle", image: UIImage(named: "drizzle") ?? UIImage(), animation: "drizzleAnimation"),
        WeatherAttributes(name: "Blizzard", image: UIImage(named: "blizzard") ?? UIImage(), animation: "blizzardAnimation"),
        WeatherAttributes(name: "Sandstorm", image: UIImage(named: "sandstorm") ?? UIImage(), animation: "sandstormAnimation"),
        WeatherAttributes(name: "Thunderstorm", image: UIImage(named: "thunderstorm") ?? UIImage(), animation: "thunderstormAnimation"),
        WeatherAttributes(name: "Partly Cloudy", image: UIImage(named: "partly_cloudy") ?? UIImage(), animation: "partlyCloudyAnimation")
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


    func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
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
        
        cell.imageWeather.image = weatherTypes[indexPath.row].image
        return cell
    }
}
