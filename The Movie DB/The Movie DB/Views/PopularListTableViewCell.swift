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
    @IBOutlet weak var popularityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(
        name: String,
        department:String,
        imageString:String,
        popularity : Float
    ){
        self.nameLabel.text = name
        self.departmentLabel.text = "Department: \(department)"
        self.popularityLabel.text = "Popularity : \(String(popularity))"
        let imageURL = URL(string: imageString)
        self.posterImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultphoto"))
    }
    
}
