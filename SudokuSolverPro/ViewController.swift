//
//  ViewController.swift
//  SudokuSolverPro
//
//  Created by Eshan on 27/07/26.
//

import UIKit

class ViewController: UIViewController {
    
    let board: [[Int]] = [
        [5, 3, 0, 0, 7, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ]
    
    var selectedIndex : Int = -1
    var selectedGridIndices: [Int] = []
    
    @IBOutlet weak var sudokuBackView: UIView!
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sudokuCollectionView.register(UINib(nibName: "SudokuCellCVC", bundle: nil), forCellWithReuseIdentifier: "SudokuCellCVC")
        sudokuCollectionView.delegate = self
        sudokuCollectionView.dataSource = self
//        sudokuCollectionView.backgroundColor = UIColor.black
        sudokuBackView.backgroundColor = UIColor.outerBoundary()
        sudokuCollectionView.backgroundColor = UIColor.innerBoundary()
        
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
//        cell.textLabel.text = "\(indexPath.row / 9), \(indexPath.row % 9)"
        
        let rowValue : Int = indexPath.row / 9
        let colValue : Int = indexPath.row % 9
        
        if selectedIndex != -1 {
            let selectedRow = selectedIndex / 9
            let selectedCol = selectedIndex % 9
            
            if selectedRow == rowValue || selectedCol == colValue || selectedGridIndices.contains(row) {
                cell.backView.backgroundColor = UIColor.selectedBackground()
            } else {
                cell.backView.backgroundColor = UIColor.white
            }
            
            if selectedIndex == indexPath.row {
                cell.backView.backgroundColor = UIColor.selectedBackground2()
            }
            
        }
        
        if(board[rowValue][colValue] != 0){
            cell.textLabel.text = "\(board[rowValue][colValue])"
        } else {
            cell.textLabel.text = ""
        }
        
//        cell.textLabel.text = "\(row)"
        
        cell.topOuterView.backgroundColor = UIColor.innerBoundary()
        cell.bottomOuterView.backgroundColor = UIColor.innerBoundary()
        cell.leadingOuterView.backgroundColor = UIColor.innerBoundary()
        cell.trailingOuterView.backgroundColor = UIColor.innerBoundary()
        
        cell.topInnerView.isHidden = true
        cell.bottomInnerView.isHidden = true
        cell.leadingInnerView.isHidden = true
        cell.trailingInnerView.isHidden = true
        
        // Inner Top Line
        if(row >= 1 && row <= 9) {
            cell.topInnerView.isHidden = false
            cell.topInnerView.backgroundColor = UIColor.outerBoundary()
            cell.topOuterView.backgroundColor = UIColor.outerBoundary()
        }
        
        // Inner Leading Line
        if((row - 1) % 9 == 0) {
            cell.leadingInnerView.isHidden = false
            cell.leadingInnerView.backgroundColor = UIColor.outerBoundary()
            cell.leadingOuterView.backgroundColor = UIColor.outerBoundary()
        }
        
        // Inner Trailing Line
        if(row % 9 == 0 || row % 3 == 0) {
            cell.trailingInnerView.isHidden = false
            cell.trailingInnerView.backgroundColor = UIColor.outerBoundary()
            cell.trailingOuterView.backgroundColor = UIColor.outerBoundary()
        }
        
        // Inner Bottom Line
        if(row >= 73 && row <= 81 || row >= 46 && row <= 54 || row >= 19 && row <= 27) {
            cell.bottomInnerView.isHidden = false
            cell.bottomInnerView.backgroundColor = UIColor.outerBoundary()
            cell.bottomOuterView.backgroundColor = UIColor.outerBoundary()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(selectedIndex != indexPath.row) {
            
            selectedIndex = indexPath.row
            
            selectedGridIndices.removeAll()
            
            let selectedRow = selectedIndex / 9
            let selectedCol = selectedIndex % 9
            
            let gridRow = selectedRow / 3
            let gridCol = selectedCol / 3

            for i in 0..<3 {
                for j in 0..<3 {
                    let cellRow = 3 * gridRow + i
                    let cellCol = 3 * gridCol + j
                    let index = cellRow * 9 + cellCol + 1
                    selectedGridIndices.append(index)
                }
            }
            
        }
        self.sudokuCollectionView.reloadData()
    }
}
