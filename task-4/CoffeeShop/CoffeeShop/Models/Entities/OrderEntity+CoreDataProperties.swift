//
//  OrderEntity+CoreDataProperties.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
//
//

public import Foundation
public import CoreData


public typealias OrderEntityCoreDataPropertiesSet = NSSet

extension OrderEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderEntity> {
        return NSFetchRequest<OrderEntity>(entityName: "OrderEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var paymentMethod: String?
    @NSManaged public var status: String?
    @NSManaged public var totalAmount: Double
    @NSManaged public var purchasedAt: Date?
    @NSManaged public var orderItems: NSSet?

}

// MARK: Generated accessors for orderItems
extension OrderEntity {

    @objc(addOrderItemsObject:)
    @NSManaged public func addToOrderItems(_ value: OrderItemEntity)

    @objc(removeOrderItemsObject:)
    @NSManaged public func removeFromOrderItems(_ value: OrderItemEntity)

    @objc(addOrderItems:)
    @NSManaged public func addToOrderItems(_ values: NSSet)

    @objc(removeOrderItems:)
    @NSManaged public func removeFromOrderItems(_ values: NSSet)

}

extension OrderEntity : Identifiable {

}
