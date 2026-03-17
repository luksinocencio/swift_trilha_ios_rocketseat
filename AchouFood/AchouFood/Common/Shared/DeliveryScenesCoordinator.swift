import UIKit

class DeliveryScenesCoordinator {
    private var navigationController: UINavigationController?
    
    func start() -> UINavigationController? {
        self.navigationController = UINavigationController(rootViewController: HomeDeliveryViewController())
        return self.navigationController
    }
}
