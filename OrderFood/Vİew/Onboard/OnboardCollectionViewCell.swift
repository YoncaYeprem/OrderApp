//
//  OnboardCollectionViewCell.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 28.08.2022.
//

import UIKit

class OnboardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    @IBOutlet weak var slideTitle: UILabel!
    
    @IBOutlet weak var slideDescription: UILabel!
    
    func setup(slide:OnboardModel){
        slideImageView.image = slide.image
        slideTitle.text = slide.title
        slideDescription.text = slide.description
    }
}
