//
//  ImageGalleryPresenter.swift
//  GalleryApp
//
//  Created by Даниил on 2024/01/19.
//

import Foundation

protocol ImageGalleryPresenterProtocol {
    func attachView(view: ImageGalleryViewControllerProtocol)
    func makeFirstRequest()
    var numberOfRows: Int { get }
    var imageModel: [ImageModel] { get set }
    func loadImageData(for indexPath: IndexPath, completion: @escaping (Data?) -> Void)
}


class ImageGalleryPresenter {
    weak private var view: ImageGalleryViewControllerProtocol?
    public var imageModel: [ImageModel] = []
    
    func loadImageData(for indexPath: IndexPath, completion: @escaping (Data?) -> Void) {
        guard indexPath.row < imageModel.count else {
            completion(nil)
            return
        }
        
        let imageUrl = imageModel[indexPath.row].urls.regular
        fetchImageData(for: imageUrl) { data in
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    private func fetchImageData(for imageUrl: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
    
    private func decodeData(with data: Data) {
        do {
            let decoder = JSONDecoder()
            let imageInfo = try decoder.decode([ImageModel].self, from: data)
            self.imageModel.append(contentsOf: imageInfo)
            DispatchQueue.main.async {
                self.view?.updateView()
            }
        } catch {
            print("Ошибка декодирования: \(error)")
        }
    }
}

extension ImageGalleryPresenter: ImageGalleryPresenterProtocol {
    var numberOfRows: Int {
        return imageModel.count
    }
    
    func attachView(view: ImageGalleryViewControllerProtocol) {
        self.view = view
    }
    
    func makeFirstRequest() {
        let url = URL(string: "https://api.unsplash.com/photos?client_id=1Ofh78IL-2UIRchVNCr1mIRwZfmp8In-12_1KT5wHkc&order_by=ORDER&per_page=30")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Ошмбка: \(error)")
            } else if let data = data {
                decodeData(with: data)
            }
        }
        task.resume()
    }
}
