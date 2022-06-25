//
//  CollectionView.swift
//  Final Animation
//
//  Created by Ilias Nikolaidis Olsson on 2021-06-12.
//

import UIKit

public class CollectionView: UICollectionView {
    
    public weak var gestureDelegate: ScrollViewGestureDelegate?
    
    public init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public convenience init() {
        self.init(layout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public extension CollectionView {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer  {
            return gestureDelegate?.scrollingCanBegin(self) ?? true
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
    static func actions<T: Equatable>(toGetFrom fromItems: [T], toItems: [T]) -> (indiciesToRemove: [Int], indexMovements: [Movement<Int>], indiciesToInsert: [Int], indiciesToReload: [Int]) {
        var indiciesRemoved = [Int]()
        var indexMovements = [Movement<Int>]()
        var indiciesInserted = [Int]()
        var indiciesNeedingUpdate = [Int]()
        
        var itemsAfterRemoval = fromItems
        for index in itemsAfterRemoval.indices.reversed() {
            let oldItem = itemsAfterRemoval[index]
            if !toItems.contains(oldItem) {
                indiciesRemoved.append(index)
                itemsAfterRemoval.remove(at: index)
            }
        }
        
        func generateMovement(toGetFromItems fromItems: inout [T], toItems: [T]) -> [Movement<Int>] {
            var madeMovements = [Movement<Int>]()
            for currentIndex in fromItems.indices {
                let fromItem = fromItems[currentIndex]
                let targetIndex = toItems.firstIndex(of: fromItem)!
                if currentIndex != targetIndex {
                    madeMovements.append(.init(from: currentIndex, to: targetIndex))
                    if currentIndex < targetIndex {
                        fromItems.insert(fromItem, at: targetIndex)
                        fromItems.remove(at: currentIndex)
                    } else {
                        fromItems.remove(at: currentIndex)
                        fromItems.insert(fromItem, at: targetIndex)
                    }
                }
            }
            return madeMovements
        }
        
        let itemsAfterRemovalOrdered = itemsAfterRemoval.sorted(by: {a, b in toItems.firstIndex(of: a)! < toItems.firstIndex(of: b)!})
        indexMovements = generateMovement(toGetFromItems: &itemsAfterRemoval, toItems: itemsAfterRemovalOrdered)
        
        for index in toItems.indices {
            if !(itemsAfterRemovalOrdered.count - 1 >= index && itemsAfterRemovalOrdered[index] == toItems[index])  {
                indiciesInserted.append(index)
            } else {
                indiciesNeedingUpdate.append(index)
            }
        }
        return (indiciesRemoved, indexMovements, indiciesInserted, indiciesNeedingUpdate)
    }
    
}
