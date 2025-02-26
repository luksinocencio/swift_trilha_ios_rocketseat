import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let viewContent = SplashView()
        let viewController = SplashViewController(
            contentView: viewContent,
            flowDelegate: flowDelegate
        )
        return viewController
    }
    
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let viewContent = LoginBottomSheetView()
        let viewController = LoginBottomSheetViewController(
            contentView: viewContent,
            flowDelegate: flowDelegate
        )
        return viewController
    }
    
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let viewContent = HomeView()
        let viewController = HomeViewController(
            contentView: viewContent,
            flowDelegate: flowDelegate
        )
        return viewController
    }
    
    func makeRecipesViewController() -> NewReceiptViewController {
        let viewController = NewReceiptViewController()
        return viewController
    }
}
