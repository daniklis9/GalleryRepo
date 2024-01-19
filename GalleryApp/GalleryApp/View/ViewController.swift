//
//  ViewController.swift
//  GalleryApp
//
//  Created by Даниил on 2024/01/18.
//

import UIKit

protocol ImageGalleryViewControllerProtocol: AnyObject {
}

class ImageGalleryViewController: UIViewController {

    private var presenter: ImageGalleryPresenterProtocol = ImageGalleryPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }


}

extension ImageGalleryViewController: ImageGalleryViewControllerProtocol {

}

