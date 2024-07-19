import UIKit

class CellFirstScreen: UICollectionViewCell {
    var imageWeather = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageWeatherSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageWeatherSettings() {
        imageWeather.clipsToBounds = true
        imageWeather.contentMode = .scaleAspectFit
        imageWeather.backgroundColor = .lightGray
        contentView.addSubview(imageWeather)
        setupCellConstraints()
    }

    private func setupCellConstraints() {
        imageWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageWeather.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageWeather.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageWeather.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
