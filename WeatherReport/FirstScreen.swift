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

        // Select a random image and start the animation
        let randomIndex = Int.random(in: 0..<weatherTypes.count)
        let randomWeather = weatherTypes[randomIndex]
        animateImage(image: randomWeather.image)
        updateWeatherLabel(with: randomWeather.name)
    }
    
    // Initializes the weather types with images and names
    // Parameter tintColor: The color used to tint the weather icons
    // Returns: An array of `WeatherAttributes` with different weather types
    private func initializeWeatherTypes(with tintColor: UIColor) -> [WeatherAttributes] {
        return [
            WeatherAttributes(name: NSLocalizedString("fog", comment: ""), image: UIImage(systemName: "cloud.fog.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("rain", comment: ""), image: UIImage(systemName: "cloud.rain.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("hail", comment: ""), image: UIImage(systemName: "cloud.hail.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("snow", comment: ""), image: UIImage(systemName: "cloud.snow.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("windy", comment: ""), image: UIImage(systemName: "wind")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("sunny", comment: ""), image: UIImage(systemName: "sun.max.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("sleet", comment: ""), image: UIImage(systemName: "cloud.sleet.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("cloudy", comment: ""), image: UIImage(systemName: "cloud.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("tornado", comment: ""), image: UIImage(systemName: "tornado")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("drizzle", comment: ""), image: UIImage(systemName: "cloud.drizzle.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("blizzard", comment: ""), image: UIImage(systemName: "cloud.snow.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("sandstorm", comment: ""), image: UIImage(systemName: "sun.dust.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("thunderstorm", comment: ""), image: UIImage(systemName: "cloud.bolt.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage()),
            WeatherAttributes(name: NSLocalizedString("partlyCloudy", comment: ""), image: UIImage(systemName: "cloud.sun.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) ?? UIImage())
        ]
    }

    // Sets up the collection view with its layout, data source, and delegate
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CellFirstScreen.self, forCellWithReuseIdentifier: "CellFirstScreen")

        setupCollectionViewConstraints()
    }

    // Configures the layout of the collection view
    // Returns: `UICollectionViewFlowLayout` with horizontal scrolling and calculated item size
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

    // Sets up the constraints for the collection view
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

    // Sets up the weather label with initial properties and constraints
    private func setupWeatherLabel() {
        weatherLabel = UILabel()
        weatherLabel.textAlignment = .center
        weatherLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
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

    // Updates the weather label with the given text
    // Parameter text: The text to display in the weather label
    private func updateWeatherLabel(with text: String) {
        weatherLabel.text = text
    }
    
    // MARK: - UICollectionViewDataSource
    
    // Returns the number of items in the collection view section
    // Parameter collectionView: The collection view requesting this information
    // Parameter section: The section of the collection view
    // Returns: The number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTypes.count
    }

    // Configures and returns a cell for the collection view
    // Parameter collectionView: The collection view requesting this information
    // Parameter indexPath: The index path of the cell to be returned
    // Returns: A configured `UICollectionViewCell`
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

    // Animates the image with fade and scale effects
    // Parameter image: The image to be animated
    private func animateImage(image: UIImage) {
        animatedImageView?.layer.removeAllAnimations()
        animatedImageView?.removeFromSuperview()
        
        // Initial size of the image
        let initialSize: CGFloat = 200
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.8
        view.addSubview(imageView)
        
        animatedImageView = imageView
        updateAnimatedImageViewFrame()

        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 0.8
        fadeOutAnimation.toValue = 0.2
        fadeOutAnimation.duration = 0.8
        fadeOutAnimation.autoreverses = true
        fadeOutAnimation.repeatCount = .infinity

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 2.0 // Увеличение масштаба
        scaleAnimation.duration = 0.8
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity

        imageView.layer.add(fadeOutAnimation, forKey: "fadeOut")
        imageView.layer.add(scaleAnimation, forKey: "scale")
    }

    // Updates the frame of the animated image view based on the current screen size
    private func updateAnimatedImageViewFrame() {
        guard let imageView = animatedImageView else { return }

        let isLandscape = view.bounds.width > view.bounds.height
        let initialSize: CGFloat = isLandscape ? 100 : 200

        // Calculate maximum size for the image to avoid overlap with collection view
        let padding: CGFloat = 20
        let verticalInset: CGFloat = 40
        let maxSize = min(view.bounds.width - 3 * padding, view.bounds.height - 3 * verticalInset)
        
        let finalSize = min(initialSize, maxSize)
        imageView.frame = CGRect(
            x: view.bounds.midX - finalSize / 2,
            y: view.bounds.midY - finalSize / 2,
            width: finalSize,
            height: finalSize
        )
    }
    
    // Transitions to a new image with animation and updates the weather label
    // Parameters: newImage: The new image to transition to; name: The name of the weather to display in the label
    private func transitionToNewImage(newImage: UIImage, withName name: String) {
        guard let imageView = animatedImageView else { return }

        UIView.animate(withDuration: 0.5, animations: {
            imageView.alpha = 0.0
        }) { _ in
            imageView.image = newImage
            self.updateAnimatedImageViewFrame()
            
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

    // Updates the position and size of the animated image view when the screen orientation changes
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateAnimatedImageViewFrame()
    }
}
