//
//  DifficultyTVC.swift
//  SudokuSolverPro
//
//  Created by Eshan on 07/08/26.
//

import UIKit

class DifficultyTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,
                     UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var difficultyCVC: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var dataArray : [DifficultyCellData] = []
    
    weak var delegate : DifficultyDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = "Difficulty"
        titleLabel.font = UIFont.semibold(18)
        titleLabel.textColor = UIColor.textColor()
        
        difficultyCVC.register(
            UINib(nibName: "DifficultyCVC", bundle: nil),
            forCellWithReuseIdentifier: "DifficultyCVC"
        )
        difficultyCVC.delegate = self
        difficultyCVC.dataSource = self
        difficultyCVC.backgroundColor = UIColor.clear
        
    }
    
    func bindData(dataArray : [DifficultyCellData]){
        self.dataArray = dataArray
        self.difficultyCVC.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DifficultyCVC", for: indexPath) as! DifficultyCVC
        cell.bindData(data: self.dataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, 72.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data : DifficultyCellData = self.dataArray[indexPath.row]
        
        delegate?.didSelectDifficulty(data.title.lowercased())
        
    }
    
}
