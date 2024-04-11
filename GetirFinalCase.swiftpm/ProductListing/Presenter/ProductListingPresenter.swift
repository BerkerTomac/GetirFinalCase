import Foundation


class ProductListingPresenter: ProductListingPresenterProtocol, ProductListingInteractorOutputProtocol {
    weak var view: ProductListingViewProtocol?
    var interactor: ProductListingInteractorInputProtocol?
    var router: ProductListingRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchSuggestedProducts()
        interactor?.fetchProducts()
    }

    func suggestedProductsFetched(_ suggestedProducts: [SuggestedProduct]) {
        view?.displaySuggestedProducts(suggestedProducts)
    }

    func productsFetched(_ categories: [Category]) {
        view?.displayProducts(categories)
    }

    func productsFetchingFailed(_ error: Error) {
        view?.displayError("Failed to fetch products: \(error.localizedDescription)")
    }

    func didSelectProduct(_ product: Product) {
        // Assuming ProductDetailViewController exists and is part of your storyboard or instantiated programmatically
        router?.navigateToProductDetail(from: view!, withProduct: product)
    }

    func didSelectSuggestedProduct(_ suggestedProduct: SuggestedProduct) {
        // Here you might want to convert SuggestedProduct to Product if they are used differently in your app
        // For the purpose of this example, let's assume they are similar
        let product = Product(id: suggestedProduct.id, name: suggestedProduct.name, attribute: suggestedProduct.shortDescription, thumbnailURL: suggestedProduct.imageURL, imageURL: suggestedProduct.imageURL, price: suggestedProduct.price, priceText: suggestedProduct.priceText, shortDescription: suggestedProduct.shortDescription)
        router?.navigateToProductDetail(from: view!, withProduct: product)
    }
}
