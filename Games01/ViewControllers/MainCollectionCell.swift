//
//  MainCollectionCell.swift
//  Games01
//
//  Created by JongHyun Park on 2020/10/07.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    func initUI() {
        self.containerView.layer.cornerRadius = 20
        self.containerView.layer.borderWidth = 2
        self.containerView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
        
    }
}
