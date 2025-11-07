import Foundation

protocol ClientFormViewDelegate: AnyObject {
    func didTapCancel()
    func didTapSave()
    func didTapDelete()
}
