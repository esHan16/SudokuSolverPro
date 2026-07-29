//
//  SudokuKeysCVC.swift
//  SudokuSolverPro
//
//  Created by Eshan on 30/07/26.
//

import UIKit

protocol SudokuKeysCVCDelegate : AnyObject {
    func didTapOnKey(key: Int)
}

class SudokuKeysCVC: UICollectionViewCell {
    
    var indexKey : Int = 0
    
    weak var delegate : SudokuKeysCVCDelegate?

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        self.backView.layer.cornerRadius = self.backView.frame.height / 2.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    func bindData(key : Int){
        indexKey = key + 1
        self.titleLabel.text = "\(indexKey)"
        defaultCell()
    }
    
    func cellSelected(){
        self.titleLabel.textColor = UIColor.white
        self.backView.backgroundColor = UIColor.selectedKeyColor()
    }
    
    func defaultCell(){
        self.titleLabel.textColor = UIColor.textColor()
        self.backView.backgroundColor = UIColor.defaultKeyColor()
    }

    @objc func viewTapped() {
        cellSelected()
        self.delegate?.didTapOnKey(key: indexKey)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) { [weak self] in
            self?.defaultCell()
        }
        
    }
}
