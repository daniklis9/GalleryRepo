//
//  ImageModel.swift
//  GalleryApp
//
//  Created by Даниил on 2024/01/19.
//

import Foundation

struct ImageModel: Codable {
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    var regularUrl: URL {
        return URL(string: regular)!
    }
}
