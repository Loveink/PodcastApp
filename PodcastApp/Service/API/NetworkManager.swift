//
//  NetworkManager.swift
//  PodcastApp
//
//  Created by Александра Савчук on 27.09.2023.
//

import Foundation
import CommonCrypto

enum APIError: Error {
  case decodingError
  case networkError(Error)
}

final class NetworkService {
  let apiKey: String
  let apiSecret: String
  let apiHeaderTime: String
  
  lazy var hash: String = {
    return computeHash(apiKey: apiKey, apiSecret: apiSecret, apiHeaderTime: apiHeaderTime)
  }()
  
  init() {
    apiKey = "MLPEZ3WNT7NMZA6YZL9F"
    apiSecret = "wj93ak7FWqnkpspFgtZ87XeznTd89AGWRbpJ7$SL"
    apiHeaderTime = String(Int(Date().timeIntervalSince1970))
  }
  
  func computeHash(apiKey: String, apiSecret: String, apiHeaderTime: String) -> String {
    let combinedString = apiKey + apiSecret + apiHeaderTime
    if let data = combinedString.data(using: .utf8) {
      var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
      _ = data.withUnsafeBytes {
        CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
      }
      let hexBytes = digest.map { String(format: "%02hhx", $0) }
      return hexBytes.joined()
    }
    return ""
  }

  func fetchData<T: Decodable>(forPath path: String, completion: @escaping (Result<T, APIError>) -> Void) {
    let baseURL = "https://api.podcastindex.org/api/1.0"
    let userAgent = "PodcastApp/1.0"
    let apiUrl = URL(string: baseURL + path)!

    var request = URLRequest(url: apiUrl, timeoutInterval: Double.infinity)
    request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
    request.addValue(apiKey, forHTTPHeaderField: "X-Auth-Key")
    request.addValue(apiHeaderTime, forHTTPHeaderField: "X-Auth-Date")
    request.addValue(hash, forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(.networkError(error)))
        return
      }

      guard let data = data else {
        completion(.failure(.decodingError))
        return
      }

      do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodedData))
      } catch {
        completion(.failure(.decodingError))
      }
    }
    task.resume()
  }
}
