//
//  ViewController.swift
//  GalleryApp
//
//  Created by Даниил on 2024/01/18.
//

import UIKit

protocol ImageGalleryViewControllerProtocol: AnyObject {
    func updateView()
}

class ImageGalleryViewController: UIViewController, ImageGalleryViewControllerProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    private var presenter: ImageGalleryPresenterProtocol = ImageGalleryPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.makeFirstRequest()
        setupUI()
        setupCollectionView()
    }
    
    func updateView() {
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        self.collectionView.backgroundColor = .clear
        collectionView.register(UINib.init(nibName: ImageGalleryCollectionViewCell.cellID, bundle: Bundle.main), forCellWithReuseIdentifier: ImageGalleryCollectionViewCell.cellID)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .black
    }
}

extension ImageGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageGalleryCollectionViewCell.cellID, for: indexPath) as! ImageGalleryCollectionViewCell
        presenter.loadImageData(for: indexPath) { data in
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.setImage(image: image)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 10
        let height: CGFloat = 280.0
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, estimatedItemSizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 10
        let height: CGFloat = 280.0
        return CGSize(width: width, height: height)
    }
}
