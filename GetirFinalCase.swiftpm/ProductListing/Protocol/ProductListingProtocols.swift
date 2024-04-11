// ProductListingProtocols.swift

import UIKit
import Foundation

protocol ProductListingViewProtocol: AnyObject {
    func displaySuggestedProducts(_ suggestedProducts: [SuggestedProduct])
    func displayProducts(_ categories: [Category])
    func displayError(_ message: String)
}

protocol ProductListingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectProduct(_ product: Product)
    func didSelectSuggestedProduct(_ suggestedProduct: SuggestedProduct)
}

protocol ProductListingInteractorInputProtocol: AnyObject {
    func fetchSuggestedProducts()
    func fetchProducts()
}

protocol ProductListingInteractorOutputProtocol: AnyObject {
    func suggestedProductsFetched(_ suggestedProducts: [SuggestedProduct])
    func productsFetched(_ categories: [Category])
    func productsFetchingFailed(_ error: Error)
}

protocol ProductListingRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToProductDetail(from view: ProductListingViewProtocol, withProduct product: Product)
    func navigateToCart(from view: ProductListingViewProtocol)
}
