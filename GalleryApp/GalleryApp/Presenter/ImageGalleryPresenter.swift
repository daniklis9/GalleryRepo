//
//  ImageGalleryPresenter.swift
//  GalleryApp
//
//  Created by Даниил on 2024/01/19.
//

import Foundation

protocol ImageGalleryPresenterProtocol {
    func attachView(view: ImageGalleryViewControllerProtocol)
}

class ImageGalleryPresenter {
    weak private var view: ImageGalleryViewControllerProtocol?
    
    
}

extension ImageGalleryPresenter: ImageGalleryPresenterProtocol {    
    func attachView(view: ImageGalleryViewControllerProtocol) {
        self.view = view
    }
}
