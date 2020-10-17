//
//  ImagesAsyncController.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 03.10.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ImagesAsyncController: ASDKViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {
    
    let service = ServiceNetwork()
    var photos: [Foto] = []
    var alboms: [AlbomVK] = []
    var albomsDic: [Int : [Foto]] = [:]
    var userId: Int = 0
    
    var tableNode: ASTableNode {
        return node as! ASTableNode
    }
    

    
    
    // MARK: - Init
    
    
    override init() {
        super.init(node: ASTableNode())
        
        self.tableNode.delegate = self
        self.tableNode.dataSource = self
        self.tableNode.allowsSelection = false
       // self.tableNode.view.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("friendId= \(userId)")
        service.getFriendsPhotoForTexture(friend: userId){ [weak self] (photos) in
            self?.photos = photos
            self?.tableNode.reloadData()
        }
        
        service.getAlbomVK(friend: userId){ [weak self] (alboms) in
            alboms.forEach{ [weak self] (item) in
                guard let self = self else {return}
                self.albomsDic = self.getAlbomArray(albomId: item.id, userId: item.ownerId)
                print(self.albomsDic)
            }
            self?.alboms = alboms
            self?.tableNode.reloadData()
        }
        
    }
    
    func getAlbomArray(albomId: Int, userId: Int) -> [Int : [Foto]] {
        var tmpAlbomsDic: [Int : [Foto]] = [:]
        service.getPhotoAlbomVK(friend: userId, albumId: albomId){ (foto) in
            print("foto--------------------------------------------- \(foto)")
            
        }
        return tmpAlbomsDic
    }
    
    // MARK: - ASTableDelegate, ASTableDataSource
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = photos[indexPath.row]
        
        let cellNodeBlock = { () -> ASCellNode in
            return NewsPhotoNode(item: item)
            
        }
        return cellNodeBlock
    }
    
}
