//
//  PhotoNode.swift
//  Amyskin Unit4
//
//  Created by Alexander Myskin on 17.10.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import AsyncDisplayKit

final class NewsPhotoNode: ASCellNode {
    
    private let item: Foto
    
    // MARK - test albom
    
    let albomPhotoImageNode: ASImageNode
    let albomImageNode: ASNetworkImageNode
    
   // private let photoHeight: CGFloat = 400
    private let photoImageNode = ASNetworkImageNode()
    
    init(item: Foto) {
        self.item = item
        
        albomPhotoImageNode = ASImageNode()
        albomImageNode     = ASNetworkImageNode()
        
        super.init()
        setupNodes()
    }
    
    func setupNodes(){
        
        //Animal Image
        albomImageNode.url = URL(string: (item.photosUrl))
        albomImageNode.clipsToBounds = true
        albomImageNode.delegate = self
        albomImageNode.placeholderFadeDuration = 0.15
        albomImageNode.contentMode = .scaleAspectFill
        albomImageNode.shouldRenderProgressImages = true
        addSubnode(albomImageNode)
        
        
        
        photoImageNode.url = URL(string: (item.photosUrl))
        photoImageNode.cornerRadius = 20
        photoImageNode.clipsToBounds = true
        photoImageNode.contentMode = .scaleAspectFill
        addSubnode(photoImageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
   
        photoImageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width)
        let photoInsetSpec = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top:8, left:16, bottom: 8, right: 16),
            child: photoImageNode
        )
        
        let photoSpec = ASWrapperLayoutSpec(layoutElement: photoImageNode)

        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.spacing = 10
        verticalStackSpec.children = [photoInsetSpec]
        
        let backgroundLayoutSpec = ASBackgroundLayoutSpec(child: photoInsetSpec, background: albomPhotoImageNode)
        
        
        // C выводом каждого альбома не успел :(
        return photoInsetSpec
        
    }
    
    
}

extension NewsPhotoNode: ASNetworkImageNodeDelegate {
  func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
    albomPhotoImageNode.image = image
  }
}
