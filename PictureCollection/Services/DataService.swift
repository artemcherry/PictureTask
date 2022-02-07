//
//  DataService.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 02.02.2022.
//

import Foundation

class DataService {
    
    private var networkManager = NetworkManager()
    private var realmManager = RealmManager()
    
    func getPictures(completion: @escaping([PictureModel]?, Error?) -> Void)  {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let self = self else { return }
                self.networkManager.getPictureData { pictures, error in
                    if let pictures = pictures {
                        DispatchQueue.main.async {
                            completion(pictures, nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                    }
                }
            }
    }
    
    func loadPictures() -> [PictureModel] {
        return realmManager.loadFavorite()
    }
    
    func addToFavourite(model: PictureModel) {
        realmManager.addToFavorite(model: model)
    }
}
