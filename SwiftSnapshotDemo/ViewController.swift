//
//  ViewController.swift
//  SwiftSnapshotDemo
//
//  Created by 高鑫 on 2017/11/25.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let imgs = ["1","2","3","4","5","6","7"]
    var selectedCell : CollectionViewCell?
    var snapshotView : UIView?
    var afterSnapshotView : UIView?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var previewImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if snapshotView != nil {
            self.afterSnapshotView = self.snapshotView
            self.afterSnapshotView?.isHidden = false
            backAnimation(snapshotView: self.afterSnapshotView!, selectedCell: self.selectedCell!)
        }
        self.selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        self.snapshotView = selectedCell?.snapshotView(afterScreenUpdates: false)!
        snapshotView?.frame = self.view.convert(selectedCell!.frame, from: self.collectionView)
        self.selectedCell?.isHidden = true
        self.view.addSubview(snapshotView!)
        moveAnimation(snapshotView: snapshotView!, selectedCell: selectedCell!)
    }
    
    func backAnimation(snapshotView: UIView, selectedCell: CollectionViewCell) {
        self.previewImg.image = UIImage()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
             snapshotView.frame = self.view.convert(selectedCell.frame, from: self.collectionView)
        }) { (_) in
            selectedCell.isHidden = false
            snapshotView.removeFromSuperview()
        }
    }

    func moveAnimation(snapshotView: UIView, selectedCell : CollectionViewCell) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            snapshotView.frame = self.view.convert(self.previewImg.frame, from: self.preview)
        }) {(_) in
            snapshotView.isHidden = true
            self.previewImg.image = selectedCell.img.image
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.img.image = UIImage(named: imgs[indexPath.item])
        return cell
    }

}

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
}

