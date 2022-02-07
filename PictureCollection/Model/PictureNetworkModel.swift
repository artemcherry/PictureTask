//
//  PictureModel.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 02.02.2022.
//

import Foundation

struct PictureNetworkModel: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "download_url"
    }
}
