//
//  ProductEntity+CoreDataProperties.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
//
//

public import Foundation
public import CoreData


public typealias ProductEntityCoreDataPropertiesSet = NSSet

extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var category: CategoryEntity?

}

extension ProductEntity : Identifiable {

}
