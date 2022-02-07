//
//  PictureCell.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 02.02.2022.
//

import UIKit

final class PictureCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var favouriteButton: UIButton!
    
    var viewLink: PictureViewController?
    let identifier  = "Cell"
    
    func setupView(pictureInfo: PictureModel) {
        imageView.image = UIImage(data: pictureInfo.image)
        hideButton()
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        viewLink?.addToFavourite(cell: self)
        if sender.currentImage != UIImage(systemName: "suit.heart.fill") {
            sender.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    
    private func hideButton() {
        if viewLink?.segmentControl.selectedSegmentIndex == 1 {
            favouriteButton.isHidden = true
        } else {
            favouriteButton.isHidden = false
        }
    }
}


