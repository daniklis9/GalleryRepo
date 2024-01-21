//
//  ImageGalleryCollectionViewCell.swift
//  GalleryApp
//
//  Created by Даниил on 2024/01/19.
//

import UIKit

class ImageGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    static let cellID = "ImageGalleryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 15
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
}
