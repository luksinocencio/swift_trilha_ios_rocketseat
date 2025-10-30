import UIKit

final class HomeViewController: UIViewController {
    private let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
