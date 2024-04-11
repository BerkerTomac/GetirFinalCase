import UIKit

class ProductListingViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    var presenter: ProductListingPresenterProtocol?
    private var collectionView: UICollectionView! // The collection view for displaying products
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
    }

    private func configureUI() {
        // Configure the overall UI of the view controller, including navigation items if necessary
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        // Initialize the collection view with a compositional layout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)

        // Register cell classes
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        collectionView.register(SuggestedProductCell.self, forCellWithReuseIdentifier: SuggestedProductCell.reuseIdentifier)
        
        configureDataSource()
    }

    private func createCompositionalLayout() -> UICollectionViewLayout {
        // Create a compositional layout for the collection view
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            // Return appropriate sections based on sectionNumber
            // For example, section 0 could be horizontal scrolling, section 1 could be vertical scrolling
            return sectionNumber == 0 ? self.createSuggestedProductsSection() : self.createRegularProductsSection()
        }
        return layout
    }

    private func createSuggestedProductsSection() -> NSCollectionLayoutSection {
        // Define the size for each item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        // Create a group horizontally
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.35)) // Adjust your height dimension accordingly
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        // Create a section with the above group
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging // Makes the cell paging-like behavior
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }


    private func createRegularProductsSection() -> NSCollectionLayoutSection {
        // Define the size for each item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        // Create a group vertically
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        // Create a section with the above group
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }


    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            // Determine the item type and configure the cell accordingly
            if let product = item as? Product {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else {
                    fatalError("Could not dequeue ProductCell")
                }
                cell.setup(with: product) // Call the correct method to setup the cell
                return cell
            } else if let suggestedProduct = item as? SuggestedProduct {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestedProductCell.reuseIdentifier, for: indexPath) as? SuggestedProductCell else {
                    fatalError("Could not dequeue SuggestedProductCell")
                }
                cell.setup(with: suggestedProduct)
                return cell
            }
            return nil
        }
    }
    
    // MARK: - Display Functions Called by the Presenter
    enum Section {
        case suggested
        case products
    }

    func displaySuggestedProducts(_ suggestedProducts: [SuggestedProduct]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.suggested])
        snapshot.appendItems(suggestedProducts, toSection: .suggested)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayProducts(_ categories: [Category]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.products])
        categories.forEach { category in
            snapshot.appendItems(category.products, toSection: .products)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayError(_ message: String) {
        // Present an alert or some form of error message to the user
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension ProductListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Determine which section the item is in
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        switch section {
        case .suggested:
            if let suggestedProduct = dataSource.itemIdentifier(for: indexPath) as? SuggestedProduct {
                presenter?.didSelectSuggestedProduct(suggestedProduct)
            }
        case .products:
            if let product = dataSource.itemIdentifier(for: indexPath) as? Product {
                presenter?.didSelectProduct(product)
            }
        default:
            break
        }
    }
}
