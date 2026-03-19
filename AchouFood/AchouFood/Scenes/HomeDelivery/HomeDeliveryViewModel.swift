import Foundation

final class HomeDeliveryViewModel {
    let homeDeliveryService: HomeDeliveryServicing
    
    public init(service: HomeDeliveryServicing) {
        self.homeDeliveryService = service
    }
    
    public func fetchPlaces(completion: @escaping FetchPlacesCompletion) {
        homeDeliveryService.fetchPlaces { result in
            completion(result)
        }
    }
}
