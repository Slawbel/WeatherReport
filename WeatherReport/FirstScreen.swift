import UIKit

class FirstScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    private let tintColor = UIColor.lightGray

    private var weatherTypes: [WeatherAttributes] = []
    private var animatedImageView: UIImageView?
    private var weatherLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        weatherTypes = initializeWeatherTypes(with: tintColor)

        setupCollectionView()
        setupWeatherLabel()

        // Выбор случайного изображения и запуск анимации
        let randomIndex = Int.random(in: 0..<weatherTypes.count)
        let randomWeather = weatherTypes[randomIndex]
        animateImage(image: randomWeather.image)
        updateWeatherLabel(with: randomWeather.name)
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
        layout.scrollDirection = .horizontal
        
        let padding: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 4
        
        let collectionViewWidth = view.frame.width
        let totalPadding = padding * (numberOfItemsPerRow + 1)
        let itemWidth = (collectionViewWidth - totalPadding) / numberOfItemsPerRow
        
        let itemHeight = itemWidth
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding / 2
        
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
        
        let collectionViewHeight = min(CGFloat(numberOfRows) * (itemHeight + padding) + padding, view.frame.height * 0.15)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        ])
    }

    private func setupWeatherLabel() {
        weatherLabel = UILabel()
        weatherLabel.textAlignment = .center
        weatherLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        weatherLabel.textColor = .black
        
        view.addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            weatherLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func updateWeatherLabel(with text: String) {
        weatherLabel.text = text
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
            self.transitionToNewImage(newImage: selectedWeather.image, withName: selectedWeather.name)
        }
        return cell
    }

    private func animateImage(image: UIImage) {
        animatedImageView?.layer.removeAllAnimations()
        animatedImageView?.removeFromSuperview()
        
        let imageView = UIImageView(image: image)
        let initialSize: CGFloat = 100
        let increasedSize: CGFloat = initialSize * 2
        
        imageView.frame = CGRect(x: view.bounds.midX - initialSize / 2, y: view.bounds.midY - initialSize / 2, width: initialSize, height: initialSize)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.8
        view.addSubview(imageView)
        
        animatedImageView = imageView

        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 0.8
        fadeOutAnimation.toValue = 0.2
        fadeOutAnimation.duration = 0.8
        fadeOutAnimation.autoreverses = true
        fadeOutAnimation.repeatCount = .infinity

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 2.0
        scaleAnimation.duration = 0.8
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity

        imageView.layer.add(fadeOutAnimation, forKey: "fadeOut")
        imageView.layer.add(scaleAnimation, forKey: "scale")
    }

    private func transitionToNewImage(newImage: UIImage, withName name: String) {
        guard let imageView = animatedImageView else { return }

        UIView.animate(withDuration: 0.5, animations: {
            imageView.alpha = 0.0
        }) { _ in
            imageView.image = newImage
            
            UIView.animate(withDuration: 0.5) {
                imageView.alpha = 0.8
            }
            
            self.updateWeatherLabel(with: name)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            imageView.transform = CGAffineTransform(rotationAngle: .pi).scaledBy(x: 1.5, y: 1.5)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                imageView.transform = .identity
            }
        }
    }
}
