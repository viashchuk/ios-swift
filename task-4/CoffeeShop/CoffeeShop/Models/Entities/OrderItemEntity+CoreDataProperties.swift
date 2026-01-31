//
//  OrderItemEntity+CoreDataProperties.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
//
//

public import Foundation
public import CoreData


public typealias OrderItemEntityCoreDataPropertiesSet = NSSet

extension OrderItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItemEntity> {
        return NSFetchRequest<OrderItemEntity>(entityName: "OrderItemEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int16
    @NSManaged public var order: OrderEntity?
    @NSManaged public var product: ProductEntity?

}

extension OrderItemEntity : Identifiable {

}
