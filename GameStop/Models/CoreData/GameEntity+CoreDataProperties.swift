//
//  GameEntity+CoreDataProperties.swift
//  GameStop
//
//  Created by Güray Gül on 23.05.2024.
//
//

import Foundation
import CoreData


extension GameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntity> {
        return NSFetchRequest<GameEntity>(entityName: "GameEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var isLiked: Bool

}

extension GameEntity : Identifiable {

}
