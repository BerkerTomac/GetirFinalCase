
import Foundation
import UIKit

class SuggestedProductCell: UICollectionViewCell {
    static let reuseIdentifier = "SuggestedProductCell"
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
    
    func setup(with suggestedProduct: SuggestedProduct) {
           nameLabel.text = suggestedProduct.name
           priceLabel.text = suggestedProduct.priceText
           productImageView.loadImage(from: suggestedProduct.imageURL)
       }
}



