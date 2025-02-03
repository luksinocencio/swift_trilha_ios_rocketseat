import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSplashViewController(flowDelegate: SplashViewFlowDelegate) -> SplashViewController
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
}
