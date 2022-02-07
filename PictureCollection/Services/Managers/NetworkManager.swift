//
//  NetworkManager.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 02.02.2022.
//

import Foundation

class NetworkManager {
    
    private let url = "https://picsum.photos/300/300"
    
    func getPictureData(competion: @escaping ([PictureModel]?, Error?) -> Void) {
        var picturesData = [PictureModel]()
        
        getData(forResourse: url) { data, error in
            if let data = data {
                picturesData.append(PictureModel(image: data))
                competion(picturesData, nil)
            } else {
                competion(nil, error)
            }
        }
    }
    
    
    private func getData(forResourse: String, completion: @escaping(Data?, Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: forResourse) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(data, nil)
                }
            }
            task.resume()
        }
    }
}

