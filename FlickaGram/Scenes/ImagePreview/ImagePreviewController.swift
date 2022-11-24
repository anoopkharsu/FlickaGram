//
//  ImagePreviewController.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 24/11/22.
//

import UIKit

class ImagePreviewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images = [FlickrImageListModels.Photo]()
    var getNextImages: (() -> Void)?
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: .init(item: self.selectedIndex, section: 0), at: .left, animated: false)
        }
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
