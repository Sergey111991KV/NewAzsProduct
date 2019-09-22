//
//  ResourseRequest.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 22.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation

enum GetResourceRequest<ResourseType>{
    case success([ResourseType])
    case failure
}

enum SaveResult<ResourseType>{
    case success([ResourseType])
    case failure
}

struct ResourseRequest<ResourseType> where ResourseType: Codable {
    
    let baseURL = "http://localhost:8080/api"
    let resourceURL: URL
    
    init(resoursePath: String) {
        guard let resourceURL = URL(string: baseURL) else{
            fatalError()
        }
        self.resourceURL = resourceURL.appendingPathComponent(resoursePath)
    }
    
    func getAll(completion: @escaping (GetResourceRequest<ResourseType>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else{
                completion(.failure)
                return
            }
            do{
                let decoder = JSONDecoder()
                let resources = try decoder.decode([ResourseType].self, from: jsonData)
                completion(.success(resources))
            } catch {
                completion(.failure)
            }
        }
        dataTask.resume()
    }
}
