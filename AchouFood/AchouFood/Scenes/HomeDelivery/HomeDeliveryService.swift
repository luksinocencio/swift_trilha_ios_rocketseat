import Foundation

public typealias FetchPlacesCompletion = (Result<[Place]?, Error>) -> Void

public protocol HomeDeliveryServicing {
    func fetchPlaces(completion: @escaping FetchPlacesCompletion)
}
final class HomeDeliveryServiceMock: HomeDeliveryServicing {
    func fetchPlaces(completion: @escaping FetchPlacesCompletion) {
        let places = self.loadMoclPlaces()
        
        if let places = places {
            completion(.success(places))
        } else {
            completion(.failure(NSError()))
        }
    }
    
    private func loadMoclPlaces() -> [Place]? {
        guard let url = Bundle.main.url(forResource: "places", withExtension: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        let places = try? decoder.decode([Place].self, from: data)
        
        return places
    }
}
