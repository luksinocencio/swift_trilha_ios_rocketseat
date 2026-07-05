import Foundation

public protocol PlaceDetailCoordinator: AnyObject {
    func back()
    func openMenu(place: Place)
}
