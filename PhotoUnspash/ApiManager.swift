
import Foundation

class ApiManager {
    
    func request(searchWord: String, completion: @escaping (Data?, Error?) -> Void) {
        let parametrs = self.parametrs(searchWord: searchWord)
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = accessKey()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func accessKey() -> [String:String]? {
        var accessKey = [String:String]()
        accessKey["Authorization"] = "Client-ID h6S1A5ZQubTPSeD8peYMNo7OwF-26G7K-S8BLdZP6_s"
        return accessKey
    }
    
    private func parametrs(searchWord: String?) -> [String: String] {
        var parametrs = [String: String]()
        parametrs["per_page"] = String(20)
        parametrs["page"] = String(1)
        parametrs["query"] = searchWord
        return parametrs
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask (from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                print(request)
                completion(data, error)
            }
        }
    }
}
