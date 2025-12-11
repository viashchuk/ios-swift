//
//  Category+CoreDataProperties.swift
//  shop
//
//  Created by Victoria Iashchuk on 11/12/2025.
//
//

public import Foundation
public import CoreData


public typealias CategoryCoreDataPropertiesSet = NSSet

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Category {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Category : Identifiable {

}
