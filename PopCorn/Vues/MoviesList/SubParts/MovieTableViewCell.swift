//
//  MovieTableViewCell.swift
//  PopCorn
//
//  Created by Vqpie on 26/04/2021.
//

import UIKit



class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var underTitle: UILabel!
    
    @IBOutlet weak var affiche: UIImageView!
    
    static let reuseId: String = "MovieTableViewCellReuseID"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.affiche.image = image
            }
        }
    }
}
