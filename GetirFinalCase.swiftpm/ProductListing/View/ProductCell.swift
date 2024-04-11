import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductCell"
    private let productImageView = UIImageView()


    // Add subviews
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        priceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, priceLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 100), // Change as needed
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    func setup(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)" // Assuming `price` is a property of Product
        productImageView.loadImage(from: product.thumbnailURL!) // Use `loadImage(from:)` to load the image from URL
    }

}


extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return // In production, you might want to set a default image
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                // Handle errors as needed
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                return // In production, you might want to set a default image
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

