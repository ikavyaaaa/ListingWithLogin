//
//  ProductsTableViewCell.swift
//  LisitingWithLogin
//
//  Created by Kavya on 26/07/22.
//

import UIKit
import Kingfisher

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dict : [String : Any] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "ProductsCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "ProductsCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 70, bottom: 20, right: 40)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        collectionView!.collectionViewLayout = layout
    }
}

//MARK: - collectionView DataSource and Delegate
extension ProductsTableViewCell :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dict["values"] as! NSArray).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        let array = dict["values"] as! NSArray
        let myDict : [String : Any] = array[indexPath.row] as! [String : Any]
        cell.lblName.text = myDict["name"] as? String
        let actualPrice = myDict["actual_price"] as? String
        cell.lblActualPrice.text = actualPrice
        let offerPrice = myDict["offer_price"] as? String
        cell.lblOfferPrice.text = offerPrice
        let imgURL = myDict["image"] as! String
        cell.image.contentMode = .scaleAspectFit
        cell.image.kf.setImage(with: URL(string: imgURL))
        let offerPrie = myDict["offer"] as? Int
        cell.lblOffer.text = "\(offerPrie!)% OFF"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 200 )
    }
}
