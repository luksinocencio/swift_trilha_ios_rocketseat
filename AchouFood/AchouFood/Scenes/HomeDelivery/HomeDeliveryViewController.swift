import UIKit

class HomeDeliveryViewController: UIViewController {
    private var homeDeliveryView: HomeDeliveryView?
    
    override func loadView() {
        super.loadView()
        
        self.homeDeliveryView = HomeDeliveryView()
        self.view = HomeDeliveryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
