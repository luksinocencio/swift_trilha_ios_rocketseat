import UIKit

struct Typography {
    static let titleLg = UIFont.notoSans(ofSize: 18, weight: .semiBold)
    static let titleMd = UIFont.notoSans(ofSize: 16, weight: .semiBold)
    static let titleSm = UIFont.notoSans(ofSize: 14, weight: .semiBold)

    static let bodyMd = UIFont.notoSans(ofSize: 16, weight: .regular)
    static let bodySm = UIFont.notoSans(ofSize: 14, weight: .regular)
    static let bodyXs = UIFont.notoSans(ofSize: 12, weight: .regular)

    static let labelXs = UIFont.notoSans(ofSize: 12, weight: .semiBold)
    static let label2Xs = UIFont.notoSans(ofSize: 10, weight: .semiBold)
}

private enum NotoSansWeight {
    case regular
    case semiBold

    var fontName: String {
        switch self {
        case .regular:
            return "NotoSans-Regular"
        case .semiBold:
            return "NotoSans-SemiBold"
        }
    }

    var fallbackWeight: UIFont.Weight {
        switch self {
        case .regular:
            return .regular
        case .semiBold:
            return .semibold
        }
    }
}

private extension UIFont {
    static func notoSans(ofSize size: CGFloat, weight: NotoSansWeight) -> UIFont {
        UIFont(name: weight.fontName, size: size) ?? .systemFont(ofSize: size, weight: weight.fallbackWeight)
    }
}

/**
 titleLabel.font = Typography.titleLg
 subtitleLabel.font = Typography.bodySm
 badgeLabel.font = Typography.labelXs
 */
