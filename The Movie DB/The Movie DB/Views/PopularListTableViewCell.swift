//
//  PopularListTableViewCell.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import UIKit
import SDWebImage

class PopularListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(name: String,department:String,imageString:String){
        self.nameLabel.text = name
        self.departmentLabel.text = department
        let baseurl = "https://image.tmdb.org/t/p/w500"
        if imageString == ""{
            self.posterImageView.image = UIImage(named: "defaultphoto")
        }else{
            let fullUrl = baseurl+imageString
            let imageURL = URL(string: fullUrl)
            self.posterImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        }
    }

}
