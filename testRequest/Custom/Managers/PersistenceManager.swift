//
//  PersistenceManager.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let requests = "requests" }
    
    static func updateWith(request: Request, actionType: PersistenceActionType, completed: @escaping (TRError?) -> Void) {
        retrieveRequests { result in
            switch result {
            
            case .success(var requests):

                switch actionType {
                case .add:
                    guard !requests.contains(request) else {
                        completed(.alreadySaved)
                        return
                    }
                    
                    requests.append(request)
                    
                case .remove:
                    requests.removeAll { $0.hashValue == request.hashValue }
                }
                
                 completed(save(requests: requests))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveRequests(completed: @escaping (Result<[Request], TRError>) -> Void) {
        guard let requestsData = defaults.object(forKey: Keys.requests) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            
            let requests = try decoder.decode([Request].self, from: requestsData)
            completed(.success(requests))
        } catch {
            completed(.failure(.unableToSave))
        }
    }
    
    
    static func save(requests: [Request]) -> TRError? {
        do {
            let encoder = JSONEncoder()
            let encodedRequests = try encoder.encode(requests)
            defaults.setValue(encodedRequests, forKey: Keys.requests)
            return nil
        } catch {
            return .unableToSave
        }
    }
}
