//
//  ViewController.swift
//  SudokuSolverPro
//
//  Created by Eshan on 27/07/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sudokuCollectionView.register(UINib(nibName: "SudokuCellCVC", bundle: nil), forCellWithReuseIdentifier: "SudokuCellCVC")
        sudokuCollectionView.delegate = self
        sudokuCollectionView.dataSource = self
        sudokuCollectionView.backgroundColor = UIColor.black
        
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCellCVC", for: indexPath) as! SudokuCellCVC
        
        let row : Int = indexPath.row + 1
        
        cell.backView.backgroundColor = UIColor.white
        cell.textLabel.text = ""
        
        cell.topInnerView.isHidden = true
        cell.bottomInnerView.isHidden = true
        cell.leadingInnerView.isHidden = true
        cell.trailingInnerView.isHidden = true
        
        // Inner Top Line
        if(row >= 1 && row <= 9) {
            cell.topInnerView.isHidden = false
        }
        
        // Inner Leading Line
        if((row - 1) % 9 == 0) {
            cell.leadingInnerView.isHidden = false
        }
        
        // Inner Trailing Line
        if(row % 9 == 0 || row % 3 == 0) {
            cell.trailingInnerView.isHidden = false
        }
        
        // Inner Bottom Line
        if(row >= 73 && row <= 81 || row >= 46 && row <= 54 || row >= 19 && row <= 27) {
            cell.bottomInnerView.isHidden = false
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side : CGFloat = collectionView.frame.width / 9.0
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
}
