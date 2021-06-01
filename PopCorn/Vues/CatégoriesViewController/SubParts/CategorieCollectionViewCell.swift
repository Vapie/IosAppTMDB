//
//  CategorieCollectionViewCell.swift
//  PopCorn
//
//  Created by Vqpie on 27/04/2021.
//

import UIKit

class CategorieCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nom: UILabel!
    static let reuseId: String = "CategorieCollectionViewCellId"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
