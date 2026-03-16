import UIKit

class ReminderFlowController {
    // MARK: - Propery(ies).
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol

    // MARK: - init

    public init() {
        self.viewControllerFactory = ViewControllersFactory()
    }

    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - startFlow

    func start() -> UINavigationController? {
        let startViewController = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

// MARK: - Splash

extension ReminderFlowController: SplashFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheet = viewControllerFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        navigationController?.present(loginBottomSheet, animated: false) {
            loginBottomSheet.animateShow()
        }
        
        func navigateToHome() {
            self.navigationController?.dismiss(animated: false)
            let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - Login

extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: true)
        let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

// MARK: - Home

extension ReminderFlowController: HomeFlowDelegate {
    func logout() {
        self.navigationController?.popViewController(animated: true)
        self.openLoginBottomSheet()
    }

    func navigateToRecipes() {
        let recipesViewController = viewControllerFactory.makeRecipesViewController()
        self.navigationController?.pushViewController(recipesViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }

    func navigateMyRecipes() {
        let myReceiptsViewController = viewControllerFactory.makeMyReceiptsViewController(flowDelegate: self)
        self.navigationController?.pushViewController(myReceiptsViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - MyReceipts

extension ReminderFlowController: MyReceiptsFlowDelegate {
    func goToNewReceipts() {
        self.navigateToRecipes()
    }

    func popScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}
