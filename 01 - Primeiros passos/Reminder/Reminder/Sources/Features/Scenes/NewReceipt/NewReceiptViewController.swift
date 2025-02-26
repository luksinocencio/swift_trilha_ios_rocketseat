import UIKit

class NewReceiptViewController: UIViewController {
    private let newReceiptView  = NewReceiptView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.gray800
        view.addSubview(newReceiptView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        newReceiptView.translatesAutoresizingMaskIntoConstraints = false
        setupContentViewToBounds(contentView: newReceiptView)
    }
    
    private func setupActions() {
        
    }
}
