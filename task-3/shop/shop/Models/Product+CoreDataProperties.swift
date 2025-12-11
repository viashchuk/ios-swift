//
//  Product+CoreDataProperties.swift
//  shop
//
//  Created by Victoria Iashchuk on 11/12/2025.
//
//

public import Foundation
public import CoreData


public typealias ProductCoreDataPropertiesSet = NSSet

extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var imageName: String?
    @NSManaged public var category: Category?

}

extension Product : Identifiable {

}
