//
//  ViewController.swift
//  iConSaid
//
//  Created by Bộp Bộp on 5/8/16.
//  Copyright © 2016 Bộp Bộp. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
        
    @IBOutlet weak var SearchBox: UISearchBar!
    @IBOutlet weak var MyConlectionView: UICollectionView!
        
    var filtered:[String] = []
    var arrImage = [UIImage]()
    var arrND:[String] = []
    let backItem = UIBarButtonItem()
    var lastOffsetY:CGFloat = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "iConSaid"
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        let InfoButton:UIButton = UIButton.init(type: UIButtonType.InfoDark)
        navigationItem.setRightBarButtonItem(UIBarButtonItem(customView: InfoButton), animated: true)
        InfoButton.addTarget(self, action: #selector(ViewController.infoBTN(_:)), forControlEvents: .TouchUpInside)
        navigationController?.hidesBarsWhenKeyboardAppears = true
        let database:COpaquePointer = Connect_DB_Sqlite("Data", type: "sqlite")
        let statement:COpaquePointer = Select("SELECT * FROM SubData", database: database)
        while sqlite3_step(statement) == SQLITE_ROW {
            let rowData = sqlite3_column_text(statement, 1)
            let fieldValue = String.fromCString(UnsafePointer<CChar>(rowData))
            arrND.append(fieldValue!)
            arrImage.append(UIImage(named: fieldValue!)!)
        }
        sqlite3_finalize(statement)
        sqlite3_close(database)
    }
        
    func dismissKeyboard() {
        SearchBox.resignFirstResponder()
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastOffsetY = scrollView.contentOffset.y
        dismissKeyboard()
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.dragging {
            let hide = scrollView.contentOffset.y > self.lastOffsetY
            navigationController?.setNavigationBarHidden(hide, animated: true)
        }
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        dismissKeyboard()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = arrND.filter({ (text) -> Bool in
            let tmp:NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if (searchText == ""){
            performSelector(#selector(ViewController.dismissKeyboard), withObject:searchBar, afterDelay:0)
        }
        MyConlectionView.reloadData()
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (filtered.count == 0) {
            return arrND.count
        }else{
            return filtered.count
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionCell
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        if (filtered.count == 0) {
            cell.lblThumb.text = arrND[indexPath.row]
            cell.IMGThumb.image = arrImage[indexPath.row]
        }else{
            cell.lblThumb.text = filtered[indexPath.row]
            cell.IMGThumb.image = UIImage(named: filtered[indexPath.row])
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("iConReview", sender: self)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func infoBTN(sender: UIButton){
        performSegueWithIdentifier("infoMe", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "iConReview" {
            let indexPaths = self.MyConlectionView.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            let view2 = segue.destinationViewController as! SecondViewController
            if (filtered.count == 0){
                view2.ImagesGet = arrImage[indexPath.row]
                view2.lblText = arrND[indexPath.row]
            }else{
                view2.ImagesGet =  UIImage(named: filtered[indexPath.row])!
                view2.lblText = filtered[indexPath.row]
            }
        }
    }
        
    override func didReceiveMemoryWarning() {   super.didReceiveMemoryWarning()     }
}

