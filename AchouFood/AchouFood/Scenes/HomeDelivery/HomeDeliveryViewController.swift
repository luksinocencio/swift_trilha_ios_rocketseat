import UIKit

class HomeDeliveryViewController: UIViewController {
    
    private var homeDeliveryView: HomeDeliveryView?
    
    override func loadView() {
        self.homeDeliveryView = HomeDeliveryView()
        self.view = self.homeDeliveryView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
