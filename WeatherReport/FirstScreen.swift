import UIKit

class FirstScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    private let tintColor = UIColor.lightGray

    private var weatherTypes: [WeatherAttributes] = []
    private var animatedImageView: UIImageView? // Свойство для хранения ссылки на текущий animatedImageView

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        weatherTypes = initializeWeatherTypes(with: tintColor)

        setupCollectionView()
        
        // Выбор случайного изображения и запуск анимации
        let randomIndex = Int.random(in: 0..<weatherTypes.count)
        let randomWeather = weatherTypes[randomIndex]
        animateImage(image: randomWeather.image)
    }

    private func initializeWeatherTypes(with tintColor: UIColor) -> [WeatherAttributes] {
        return [
            WeatherAttributes(name: "Fog", image: UIImage(systemName: "cloud.fog.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Rain", image: UIImage(systemName: "cloud.rain.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Hail", image: UIImage(systemName: "cloud.hail.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Snow", image: UIImage(systemName: "cloud.snow.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Windy", image: UIImage(systemName: "wind")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Sunny", image: UIImage(systemName: "sun.max.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Sleet", image: UIImage(systemName: "cloud.sleet.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Cloudy", image: UIImage(systemName: "cloud.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Tornado", image: UIImage(systemName: "tornado")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Drizzle", image: UIImage(systemName: "cloud.drizzle.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Blizzard", image: UIImage(systemName: "cloud.snow.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Sandstorm", image: UIImage(systemName: "sun.dust.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Thunderstorm", image: UIImage(systemName: "cloud.bolt.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: "Partly Cloudy", image: UIImage(systemName: "cloud.sun.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage())
        ]
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
        let padding: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 4
        let numberOfRows = ceil(Double(weatherTypes.count) / Double(Int(numberOfItemsPerRow)))
        
        let collectionViewWidth = view.frame.width
        let totalPadding = padding * (numberOfItemsPerRow + 1)
        let itemWidth = (collectionViewWidth - totalPadding) / numberOfItemsPerRow
        let itemHeight = itemWidth
        
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

        let weather = weatherTypes[indexPath.item]
        cell.weatherButton.setImage(weather.image, for: .normal)
        cell.addActionClosure = { [weak self] in
            guard let self = self else { return }
            let selectedWeather = self.weatherTypes[indexPath.item]
            self.animateImage(image: selectedWeather.image)
        }
        return cell
    }

    private func animateImage(image: UIImage) {
        // Удаление предыдущего UIImageView и его анимации
        animatedImageView?.layer.removeAllAnimations()
        animatedImageView?.removeFromSuperview()
        
        let imageView = UIImageView(image: image)
        let initialSize: CGFloat = 100
        let increasedSize: CGFloat = initialSize * 2
        
        imageView.frame = CGRect(x: view.bounds.midX - initialSize / 2, y: view.bounds.midY - initialSize / 2, width: initialSize, height: initialSize)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.8
        view.addSubview(imageView)
        
        animatedImageView = imageView // Сохранение ссылки на текущий UIImageView

        // Эффект мерцания
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 0.8
        fadeOutAnimation.toValue = 0.2
        fadeOutAnimation.duration = 0.8
        fadeOutAnimation.autoreverses = true
        fadeOutAnimation.repeatCount = .infinity

        // Анимация увеличения
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 2.0
        scaleAnimation.duration = 0.8
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity

        // Добавляем обе анимации
        imageView.layer.add(fadeOutAnimation, forKey: "fadeOut")
        imageView.layer.add(scaleAnimation, forKey: "scale")
    }

}
