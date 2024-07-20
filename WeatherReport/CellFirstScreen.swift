import UIKit

class CellFirstScreen: UICollectionViewCell {
    var weatherButton = UIButton()
    var addActionClosure: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageWeatherSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageWeatherSettings() {
        weatherButton.clipsToBounds = true
        weatherButton.contentMode = .scaleAspectFit
        weatherButton.backgroundColor = .black
        weatherButton.contentHorizontalAlignment = .center
        weatherButton.contentVerticalAlignment = .center
        weatherButton.addAction(UIAction { [weak self] _ in
            self?.addActionClosure?()
        }, for: .touchUpInside)
        
        setupCellConstraints()
    }

    private func setupCellConstraints() {
        contentView.addSubview(weatherButton)
        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
