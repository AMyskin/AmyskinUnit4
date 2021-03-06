//
//  PhotoService.swift
//  WeatherClient
//
//  Created by Vadim on 17.09.2020.
//  Copyright © 2020 Vadim. All rights reserved.
//

import UIKit
import Alamofire

final class PhotoService {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    private static let pathName: String = {
        let fileManager = FileManager.default
        let pathName = "images"
        
        guard let cachesDirectory = fileManager
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first else { return pathName }
        
        let url = cachesDirectory.appendingPathComponent(pathName,
                                                         isDirectory: true)
        
        if !fileManager.fileExists(atPath: url.path) {
            try? fileManager.createDirectory(
                atPath: url.path,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        
        return cachesDirectory
            .appendingPathComponent(Self.pathName + "/" + hashName)
            .path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard
            let filePath = getFilePath(url: url),
            let data = image.pngData()
            else { return }
        
        FileManager.default.createFile(
            atPath: filePath,
            contents: data,
            attributes: nil
        )
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        //print(#function)
        guard
            let filePath = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: filePath),
            let modificationDate = info[.modificationDate] as? Date
            else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: filePath)
            else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    private var images = [String: UIImage]()
    
    private func loadImage(at indexPath: IndexPath, url: String) {
        //print(#function)
        AF.request(url).responseData { [weak self] (response) in
            guard
                let data = response.data,
                let image = UIImage(data: data)
                else { return }
            
            // кеш в памяти
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            // кеш на диске
            self?.saveImageToCache(url: url, image: image)
            // обновление контейнера (таблицы или коллекции)
            DispatchQueue.main.async {
                self?.container.reloadRow(at: indexPath)
            }
        }
    }
    
    func photo(at indexPath: IndexPath, url: String?) -> UIImage? {
        guard let url = url else { return nil }
        
        var image: UIImage?
        
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadImage(at: indexPath, url: url)
        }
        
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    

}

protocol DataReloadable {
    func reloadRow(at indexPath: IndexPath)
}

extension PhotoService {
    
    class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(at indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(at indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
    
}
