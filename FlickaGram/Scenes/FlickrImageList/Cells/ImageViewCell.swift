//
//  ImageViewCell.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 24/11/22.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var imageView: MyImageView!
    
    func setupData(_ photo: FlickrImageListModels.Photo) {
        titleLabelView.text = photo.title
        if let url = photo.url {
            imageView.setImage(with: url)
        }
    }
}
