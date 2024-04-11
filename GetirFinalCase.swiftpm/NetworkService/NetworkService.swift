import Foundation

// MARK: - NetworkService
class NetworkService {
    
    static let shared = NetworkService()
    
    // Generic function to fetch data from a URL and decode it into the expected type.
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }.resume()
    }
}

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
