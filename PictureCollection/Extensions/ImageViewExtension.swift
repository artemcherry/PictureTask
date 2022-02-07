//
//  ImageViewExtension.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 03.02.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
