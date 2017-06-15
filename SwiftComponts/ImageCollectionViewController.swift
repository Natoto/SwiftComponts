//
//  ViewController.swift
//  Kingfisher-Demo
//
//  Created by Wei Wang on 15/4/6.
//
//  Copyright (c) 2017 Wei Wang <onevcat@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import Kingfisher
import Agrume

class FindHouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
}

class ImageCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    let collectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let colltionView:UICollectionView? = UICollectionView(frame: CGRect(x:0, y:0, width:width, height:height), collectionViewLayout: layout)
        //注册一个cell
        colltionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
    
        colltionView?.delegate = self as? UICollectionViewDelegate;
        colltionView?.dataSource = self as? UICollectionViewDataSource;
        
        colltionView?.backgroundColor = UIColor.white
        //设置每一个cell的宽高
        layout.itemSize = CGSize(width:(width)/2, height:250)
    
        return colltionView!
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self as? UICollectionViewDelegate
        self.collectionView.dataSource = self as? UICollectionViewDataSource
        // Do any additional setup after loading the view, typically from a nib.
        title = "Kingfisher" 
        if #available(iOS 10.0, tvOS 10.0, *) {
//            self.collectionView.prefetchDataSource = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearCache(sender: AnyObject) {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
    }
    
    @IBAction func reload(sender: AnyObject) {
        self.collectionView.reloadData()
    }
}

extension ImageCollectionViewController{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let agrume = Agrume(images: images, startIndex: indexPath.row, backgroundBlurStyle: .light)
//        agrume.didScroll = { [unowned self] index in
//            self.collectionView?.scrollToItem(at: IndexPath(row: index, section: 0), at: [], animated: false)
//        }
//        agrume.showFrom(self)
        
        var images = Array<URL>.init()
        for idx in 1...10 {
            let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-\(idx + 1).jpg")!
            images.append(url)
        }
        let URLs = images //.map { $0.url }
        let agrume = Agrume(imageUrls: URLs, startIndex: indexPath.row, backgroundBlurStyle: .extraLight)
        agrume.didScroll = { [unowned self] index in
            self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: [], animated: false)
        }
        agrume.showFrom(self)
    }
}

extension ImageCollectionViewController {
   
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
     func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // This will cancel all unfinished downloading task when the cell disappearing.
        (cell as! CollectionViewCell).cellImageView.kf.cancelDownloadTask()
        self.logmethod()
        
    }
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.logmethod()
        
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-\(indexPath.row + 1).jpg")!
        
        _ = (cell as! CollectionViewCell).cellImageView.kf.setImage(with: url,
                                           placeholder: nil,
                                           options: [.transition(ImageTransition.fade(1))],
                                           progressBlock: { receivedSize, totalSize in
                                            print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
            },
                                           completionHandler: { image, error, cacheType, imageURL in
                                            print("\(indexPath.row + 1): Finished")
        })
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.logmethod()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.cellImageView.kf.indicatorType = .activity
        
        return cell
    }
}


