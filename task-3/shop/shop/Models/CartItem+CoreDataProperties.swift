//
//  CartItem+CoreDataProperties.swift
//  shop
//
//  Created by Victoria Iashchuk on 11/01/2026.
//
//

public import Foundation
public import CoreData


public typealias CartItemCoreDataPropertiesSet = NSSet

extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var quantity: Int16
    @NSManaged public var product: Product?

}

extension CartItem : Identifiable {

}
