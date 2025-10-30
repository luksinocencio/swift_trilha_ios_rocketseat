import UIKit

final class SplashView: UIView {
    let triangleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "animatedSplashTriangle"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let example = AuthenticationView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = Colors.backgroundPrimary
        addSubview(triangleImageView)
        addSubview(logoImageView)
        addSubview(example)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        example.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            triangleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            triangleImageView.topAnchor.constraint(equalTo: topAnchor),
            triangleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            triangleImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            example.centerXAnchor.constraint(equalTo: centerXAnchor),
            example.centerYAnchor.constraint(equalTo: centerYAnchor),
            example.widthAnchor.constraint(equalToConstant: 343),
            example.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
}
