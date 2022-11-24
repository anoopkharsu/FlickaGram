//
//  FlickrImageListController.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 23/11/22.
//

import UIKit

class FlickrImageListController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [FlickrImageListModels.Photo]()
    let interactor = FlickrImageListInteractor()
    weak var previewDelegate: FlickrImageListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        interactor.delegate = self
        collectionView.register(.init(nibName: "ImageViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset = .zero
        interactor.getNextImages()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let prevVC = segue.destination as? ImagePreviewController {
            prevVC.images = self.images
            previewDelegate = prevVC
            if let selected = collectionView.indexPathsForSelectedItems, let index = selected.first {
                prevVC.selectedIndex = index.item
            }
            prevVC.getNextImages = {[weak self] in
                self?.interactor.getNextImages()
            }
        }
    }
}

// MARK: Collection View
extension FlickrImageListController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        
        cell.setupData(images[indexPath.item])
        if indexPath.item >= images.count-3 {
            interactor.getNextImages()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = (view.frame.width/2)
        return .init(width: side-0.5, height: side-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ImagePreview", sender: self)
    }
}

// MARK: FlickrImageListDelegate
extension FlickrImageListController: FlickrImageListDelegate {
    func reloadList(_ images: [FlickrImageListModels.Photo]) {
        self.images = images
        collectionView.reloadData()
        previewDelegate?.reloadList(images)
    }
}
