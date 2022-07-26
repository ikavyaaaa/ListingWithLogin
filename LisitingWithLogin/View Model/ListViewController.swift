//
//  ListViewController.swift
//  LisitingWithLogin
//
//  Created by Kavya on 25/07/22.
//

import UIKit

class ListViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataArray: NSArray = NSArray()
    var filteredArray: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //Custom UI
    func setupUI() {
        //UI
        tableView.delegate = self
        tableView.dataSource = self
        //Service call and added the data to global Array
        serviceObject.GetData() { (response) in
            if let resp = response["homeData"] as? NSArray {
                self.dataArray = resp
                self.filteredArray = resp
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredArray = searchText.isEmpty ? dataArray : dataArray.filter({
//            (("$0.name" ?? "").lowercased()).contains(searchText.lowercased()) }) as NSArray
        tableView.reloadData()
    }

}

//MARK: - TableView DataSource and Delegate
extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dict : [String : Any] = self.dataArray[indexPath.row] as! [String : Any]
        if dict["type"] as! String == "banners" {
            return 181
        } else if dict["type"] as! String == "products" {
            return 600
        } else {
        return 100
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict : [String : Any] = self.filteredArray[indexPath.row] as! [String : Any]
        if dict["type"] as! String == "banners" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannersCell") as! BannerTableViewCell
            cell.dict = dict
            cell.collectionView.reloadData()
            return cell
        } else if dict["type"] as! String == "products" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell") as! ProductsTableViewCell
            cell.dict = dict
            cell.collectionView.reloadData()
            return cell
        } else {
        let cell = UITableViewCell()
        cell.contentView.backgroundColor = .white
        return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
