//
//  CircularCollectionViewLayout.swift
//  Games01
//
//  Created by JongHyun Park on 2020/10/07.
//

import UIKit

class CircularCollectionViewLayout: UICollectionViewLayout {
    var itemSize =  CGSize(width: 300, height: 450)
    
    var attributesList = [CircularCollectionViewLayoutAttributes]()
    
    var radius: CGFloat = 500 {
        didSet {
            print("didSet")
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        print("anglePerItem \(atan(itemSize.width / radius))")
        return atan(itemSize.width / radius)
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            let size = CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width, height: collectionView!.bounds.height)
            return size
        }
    }
    
    override func prepare() {
        super.prepare()
        print("prepare")
        let centerX = collectionView!.contentOffset.x + ((collectionView?.bounds.width)!/2.0)

        attributesList = (0..<collectionView!.numberOfItems(inSection: 0 )).map {
            i -> CircularCollectionViewLayoutAttributes in
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: self.collectionView!.bounds.midY)
            attributes.angle = self.angle + self.anglePerItem*CGFloat(i)
            let anchorPointY = ((itemSize.height / 1.5) + radius) / itemSize.height
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            return attributes
        }
    }
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - collectionView!.bounds.width)
    }
    
    override class var layoutAttributesClass: AnyClass {
        get {
            print("layoutAttributesClass")
            return CircularCollectionViewLayoutAttributes.self
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("layoutAttributesForElements : \(attributesList.count)")
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("layoutAttributesForItem : \(attributesList.count)")
        return attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        didSet {
            print("didSet")
            zIndex = Int(angle * 100000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        print("copy")
        let copiedAttributes: CircularCollectionViewLayoutAttributes = super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}



