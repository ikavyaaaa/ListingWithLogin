//
//  BannerTableViewCell.swift
//  LisitingWithLogin
//
//  Created by Kavya on 25/07/22.
//

import UIKit
import Kingfisher

class BannerTableViewCell: UITableViewCell {
    
    var dict : [String : Any] = [:]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "BannerCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        startTimer()
    }
    
    //For scrollling collectionview cell automatically
    func startTimer() {
        _ =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < (dict["values"] as! NSArray).count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                } else {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
    }
    
}

//MARK: - collectionView DataSource and Delegate
extension BannerTableViewCell :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dict["values"] as! NSArray).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        let array = dict["values"] as! NSArray
        let myDict : [String : Any] = array[indexPath.row] as! [String : Any]
        let imgURL = myDict["banner_url"] as! String
        cell.imgView.kf.setImage(with: URL(string: imgURL))
        cell.imgView.contentMode = .scaleToFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 181)
    }
    
}
