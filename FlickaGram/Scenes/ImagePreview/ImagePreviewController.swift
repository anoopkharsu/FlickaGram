//
//  ImagePreviewController.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 24/11/22.
//

import UIKit

class ImagePreviewController: UIViewController,TransitionInfo {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images = [FlickrImageListModels.Photo]()
    var selectedIndex = IndexPath()
    var cellView: ImageViewCell? {
        collectionView.cellForItem(at: selectedIndex) as? ImageViewCell
    }
    
    // callbacks
    var getNextImages: (() -> Void)?
    var indexChanged: ((IndexPath) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.alpha = 0
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: self.selectedIndex, at: .left, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.alpha = 1
    }
    
    func setup() {
        collectionView.register(.init(nibName: "ImageViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset = .zero
    }
    
    @IBAction func shareLinkPressed(_ sender: UIButton) {
        if let index = collectionView.indexPathsForVisibleItems.first {
            presentActivity([images[index.item].url!])
        }
    }
    
    @IBAction func shareImagePressed(_ sender: UIButton) {
        if let cell = collectionView.visibleCells.first as? ImageViewCell, let image = cell.imageView.image{
            presentActivity([image])
        }
    }
    
    func presentActivity(_ activityItems: [Any]) {
        let activity = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activity , animated: true, completion: nil)
    }
    
    @IBAction func swipeDownRecognized(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .down {
            navigationController?.popViewController(animated: true)
        }
        
    }
}

//MARK: CollectionView
extension ImagePreviewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        
        cell.imageView.contentMode = .scaleAspectFit
        cell.labelBackgroundView.backgroundColor = .darkGray
        cell.setupData(images[indexPath.item])
        
        if indexPath.item >= images.count-3 {
            getNextImages?()
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let index = collectionView.indexPathsForVisibleItems.first {
            selectedIndex = index
            indexChanged?(index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = collectionView.frame.width
        let h = collectionView.frame.height
        return .init(width: w, height: h)
    }
}

//MARK: FlickrImageListDelegate
extension ImagePreviewController: FlickrImageListDelegate {
    func reloadList(_ images: [FlickrImageListModels.Photo]) {
        self.images = images
        collectionView.reloadData()
    }
}
