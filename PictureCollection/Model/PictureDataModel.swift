//
//  PictureDataModel.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 02.02.2022.
//

import Foundation
import RealmSwift

class PictureDataModel: Object {
    @Persisted var pictureData: Data
    
   convenience init(pictureData: Data) {
       self.init()
        self.pictureData = pictureData
    }
}
