import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(
        from urlString: String?,
        placeholder: UIImage? = UIImage(systemName: "photo"),
        fadeDuration: TimeInterval = 0.3
    ) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.transition(.fade(fadeDuration)), .cacheOriginalImage]
        )
    }
}
