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
    
}

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
}


extension FlickrImageListController: FlickrImageListDelegate {
    func reloadList(_ images: [FlickrImageListModels.Photo]) {
        self.images = images
        collectionView.reloadData()
    }
}
