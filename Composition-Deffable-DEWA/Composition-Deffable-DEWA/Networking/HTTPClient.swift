//
//  HTTPClient.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 16/02/23.
//

import Foundation
import XMLParsing

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        print(urlComponents)

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                switch endpoint.responseFormat {
                case .xml:
                    guard let decodedResponse = try? XMLDecoder().decode(responseModel, from: data) else {
                        return .failure(.decode)
                    }
                    return .success(decodedResponse)
                case .json:
                    guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                        return .failure(.decode)
                    }
                    return .success(decodedResponse)
                }


            case 401:
                return .failure(.unauthorised)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            print(error.localizedDescription)
            return .failure(.unknown)
        }
    }
}
