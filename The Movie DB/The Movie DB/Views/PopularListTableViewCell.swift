//
//  PopularListTableViewCell.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import UIKit

class PopularListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(name: String,department:String){
        self.nameLabel.text = name
        self.departmentLabel.text = department
    }

}
