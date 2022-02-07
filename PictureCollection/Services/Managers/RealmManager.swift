//
//  RealmManager.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 02.02.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    private func createRealmObject() -> Realm {
        var realm: Realm {
            do {
               let realm = try Realm()
                return realm
            } catch {
                let error = NSError()
                print(error)
            }
            return realm
        }
        return realm
    }
    
    func addToFavorite(model: PictureModel) {
        let data = convertToData(model: model)
        let realm = createRealmObject()
        do {
            try realm.write {
                realm.add(data)
              
            }
        } catch {
            let error = NSError()
            print(error.localizedDescription)
        }
       
    }
    
    func loadFavorite() -> [PictureModel] {
        let realm = createRealmObject()
        let favouritePictures = Array(realm.objects(PictureDataModel.self))
        return convertToPictureModel(model: favouritePictures)
    }
    
    
    private func convertToPictureModel(model: [PictureDataModel]) -> [PictureModel] {
        return model.map {
            PictureModel(image: $0.pictureData)
        }
    }
    
    private func convertToData(model: PictureModel) -> PictureDataModel {
        return
            PictureDataModel(pictureData: model.image)
    }
}


