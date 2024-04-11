import Foundation


class ProductListingInteractor: ProductListingInteractorInputProtocol {
    weak var presenter: ProductListingInteractorOutputProtocol?


    func fetchSuggestedProducts() {
        let suggestedProductsURL = "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts"
        
        NetworkService.shared.fetchData(from: suggestedProductsURL) { [weak self] (result: Result<[SuggestedProduct], Error>) in
            switch result {
            case .success(let suggestedProducts):
                self?.presenter?.suggestedProductsFetched(suggestedProducts)
            case .failure(let error):
                self?.presenter?.productsFetchingFailed(error)
            }
        }
    }

    func fetchProducts() {
        let productsURL = "https://65c38b5339055e7482c12050.mockapi.io/api/products"
        
        NetworkService.shared.fetchData(from: productsURL) { [weak self] (result: Result<[Category], Error>) in
            switch result {
            case .success(let categories):
                self?.presenter?.productsFetched(categories)
            case .failure(let error):
                self?.presenter?.productsFetchingFailed(error)
            }
        }
    }
}
