import UIKit

class ReminderFlowController {
    // MARK: - Propery(ies).
    private var navigationController: UINavigationController?
    // private let viewControllerFactory
    
    // MARK: - init
    
    public init() {
        
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Splash.
    
    // MARK: - startFlow
    
    func start() -> UINavigationController? {
        let startViewController = SplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

// MARK: - Extension(s).

/// - Splash
extension ReminderFlowController: SplashViewFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheet = LoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        navigationController?.present(loginBottomSheet, animated: false) {
            loginBottomSheet.animateShow()
        }
    }
}

/// - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: true)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBlue
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
