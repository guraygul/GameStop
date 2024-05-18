//
//  Collection+Extension.swift
//  GameStop
//
//  Created by Güray Gül on 19.05.2024.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
