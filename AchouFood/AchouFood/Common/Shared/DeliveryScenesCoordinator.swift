import UIKit

public class DeliveryScenesCoordinator {
    private var navigationController: UINavigationController?
    
    func start() -> UINavigationController? {
        let homeDeliveryViewController = HomeDeliveryFactory.make(coordinator: self)
        self.navigationController = homeDeliveryViewController
        
        return self.navigationController
    }
}
