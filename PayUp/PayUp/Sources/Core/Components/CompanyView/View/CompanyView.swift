import UIKit

final class CompanyCell: UICollectionViewCell {
    static let identifier = "CompanyCell"
    
    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundTertiary
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
