import UIKit

final class AuthenticationView: UIView {
    private let backgroundView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "mainLogo"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.titleLarge()
        label.textColor = Colors.textHeading
        label.text = "Olá Calisto,"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.paragraphMedium()
        label.textColor = Colors.textHeading
        label.text = "Desbloqueie com segurança usando o FaceID."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let faceIdIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "faceId"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ellipse1 = UIImageView(image: UIImage(named: "Ellipse1"))
    private let ellipse2 = UIImageView(image: UIImage(named: "Ellipse2"))
    private let ellipse3 = UIImageView(image: UIImage(named: "Ellipse3"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        animateEllipses()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backgroundView)
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(faceIdIcon)
        
        addSubview(ellipse1)
        addSubview(ellipse2)
        addSubview(ellipse3)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        ellipse1.translatesAutoresizingMaskIntoConstraints = false
        ellipse2.translatesAutoresizingMaskIntoConstraints = false
        ellipse3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 45),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 94),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            faceIdIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            faceIdIcon.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60),
            faceIdIcon.widthAnchor.constraint(equalToConstant: 40),
            faceIdIcon.heightAnchor.constraint(equalToConstant: 40),
            
            ellipse1.centerXAnchor.constraint(equalTo: faceIdIcon.centerXAnchor),
            ellipse1.centerYAnchor.constraint(equalTo: faceIdIcon.centerYAnchor),
            
            ellipse2.centerXAnchor.constraint(equalTo: faceIdIcon.centerXAnchor),
            ellipse2.centerYAnchor.constraint(equalTo: faceIdIcon.centerYAnchor),
            
            ellipse3.centerXAnchor.constraint(equalTo: faceIdIcon.centerXAnchor),
            ellipse3.centerYAnchor.constraint(equalTo: faceIdIcon.centerYAnchor)
        ])
    }
    
    private func animateEllipses() {
        let ellipses = [ellipse3, ellipse2, ellipse1]
        
        for (index, ellipse) in ellipses.enumerated() {
            ellipse.alpha = 0
            UIView.animate(withDuration: 1.0, delay: Double(index) * 0.4, options: [.repeat, .autoreverse], animations: {
                ellipse.alpha = 0.15
            })
        }
    }
}
