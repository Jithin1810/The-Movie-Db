//
//  KnownForCollectionViewCell.swift
//  The Movie DB
//
//  Created by JiTHiN on 11/02/25.
//

import UIKit

class KnownForCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    func configure(imageString: String){
        let baseurl = "https://image.tmdb.org/t/p/w500"
        if imageString == ""{
            self.imageView.image = UIImage(named: "defaultphoto")
        }else{
            let fullUrl = baseurl+imageString
            let imageURL = URL(string: fullUrl)
            self.imageView
                .sd_setImage(
                    with: imageURL,
                    placeholderImage: UIImage(named: "placeholder")
                )
        }
    }
}
