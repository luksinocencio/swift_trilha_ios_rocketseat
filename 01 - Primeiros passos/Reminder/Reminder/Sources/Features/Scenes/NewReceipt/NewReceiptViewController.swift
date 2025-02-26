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
        setupActions()
    }
    
    private func setupConstraints() {
        newReceiptView.translatesAutoresizingMaskIntoConstraints = false
        setupContentViewToBounds(contentView: newReceiptView)
    }
    
    private func setupActions() {
        newReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
