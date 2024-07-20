import UIKit

class WeatherView: UIView {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func showAnimation(named: String) {
        imageView.stopAnimating()
        imageView.animationImages = nil
        
        let images = loadImages(for: named)
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        imageView.startAnimating()
    }
    
    private func loadImages(for type: String) -> [UIImage] {
        var images = [UIImage]()
        for i in 1...5 { // Assume you have 5 images for each animation type
            if let image = UIImage(named: "\(type)\(i)") {
                images.append(image)
            }
        }
        return images
    }
}
