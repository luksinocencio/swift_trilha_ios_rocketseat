import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashViewFlowDelegate) -> SplashViewController {
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
}
