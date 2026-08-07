//
//  DifficultyCVC.swift
//  SudokuSolverPro
//
//  Created by Eshan on 07/08/26.
//

import UIKit

class DifficultyCVC: UICollectionViewCell {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        overlayView.backgroundColor = UIColor.white
        overlayView.layer.borderColor = UIColor.borderColor().cgColor
        overlayView.layer.borderWidth = 1.0
        overlayView.layer.cornerRadius = 12.0
        overlayView.layer.cornerCurve = .continuous
        
        titleLabel.font = UIFont.regular(16.0)
        titleLabel.textColor = UIColor.textColor()
        
        subtitleLabel.font = UIFont.regular(13.0)
        subtitleLabel.textColor = UIColor.timerColor()
        
    }
    
    func bindData(data : DifficultyCellData) {
        iconImage.image = UIImage(named: data.iconName)
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
    }

}
