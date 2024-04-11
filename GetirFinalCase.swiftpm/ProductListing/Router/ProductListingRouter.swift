// ProductListingRouter.swift

import UIKit

class ProductListingRouter: ProductListingRouterProtocol {
    
    weak var viewController: UIViewController?

        static func createModule() -> UIViewController {
            let view = ProductListingViewController()
            let presenter = ProductListingPresenter()
            let interactor = ProductListingInteractor()
            let router = ProductListingRouter()

            view.presenter = presenter
            presenter.view = view as! any ProductListingViewProtocol
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            router.viewController = view

            return view
        }

    func navigateToProductDetail(from view: ProductListingViewProtocol, withProduct product: Product) {
        /*
        // Assuming ProductDetailViewController is your view controller for product details
        let productDetailVC = ProductDetailViewController()
        // Setup productDetailVC with the selected product information
        productDetailVC.product = product // This line assumes you have a 'product' property in your detail view controller
        
        viewController?.navigationController?.pushViewController(productDetailVC, animated: true)
         
         */
    }

    func navigateToCart(from view: ProductListingViewProtocol) {
        /*
        // Assuming CartViewController is your view controller for the cart
        let cartVC = CartViewController()
        // Setup cartVC as needed for your cart logic
        
        viewController?.navigationController?.pushViewController(cartVC, animated: true)
         */
    }
}
