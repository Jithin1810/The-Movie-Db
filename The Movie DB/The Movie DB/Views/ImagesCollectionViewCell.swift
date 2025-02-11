//
//  ImagesCollectionViewCell.swift
//  The Movie DB
//
//  Created by JiTHiN on 11/02/25.
//

import UIKit
import SDWebImage

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
    }
    
    func configure(imageString: String){
        let imageURL = URL(string: imageString)
        self.imageView
            .sd_setImage(
                with: imageURL,
                placeholderImage: UIImage(named: "defaultphoto")
            )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
