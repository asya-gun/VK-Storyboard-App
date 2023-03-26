//
//  PhotoCell.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 07.12.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePhotoCell: UIImageView!
    
    func configure(imageUrl: String) {
        imagePhotoCell.sd_setImage(with: URL(string: imageUrl))
    }
}
