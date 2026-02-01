//
//  DataSyncService.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
//

import CoreData

class DataSyncService {
    static let shared = DataSyncService()
    private let container = PersistenceController.shared.container

    private let lastSyncKey = "last_sync_date"
    private let cacheExpiration: TimeInterval = 100

    func shouldSync() -> Bool {
        guard
            let lastSync = UserDefaults.standard.object(forKey: lastSyncKey)
                as? Date
        else {
            return true
        }
        return Date().timeIntervalSince(lastSync) > cacheExpiration
    }

    func syncEverything(from response: SyncResponse) {
        container.performBackgroundTask { context in
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            do {
                let categoryEntities = self.syncCategories(
                    response.categories,
                    in: context
                )

                self.syncProducts(
                    response.products,
                    categories: categoryEntities,
                    in: context
                )

                self.syncOrders(response.orders, in: context)

                try context.save()

                UserDefaults.standard.set(Date(), forKey: self.lastSyncKey)
                print("SYNC DONE")

            } catch {
                print("SYNC ERROR: \(error)")
            }
        }
    }

    func fetchOrCreateCurrentOrder(
        from orders: [OrderEntity],
        in context: NSManagedObjectContext
    ) -> OrderEntity {
        if let existing = orders.first(where: {
            $0.status == OrderStatus.initialized.rawValue
        }) {
            return existing
        } else {
            let newOrder = OrderEntity(context: context)
            newOrder.id = Int64(Date().timeIntervalSince1970)
            newOrder.status = OrderStatus.initialized.rawValue
            newOrder.totalAmount = 0.0

            try? context.save()
            return newOrder
        }
    }

    private func syncCategories(
        _ dtos: [CategoryDTO],
        in context: NSManagedObjectContext
    ) -> [Int: CategoryEntity] {
        var dict = [Int: CategoryEntity]()
        for dto in dtos {
            let entity = CategoryEntity(context: context)
            entity.id = Int64(dto.id)
            entity.name = dto.name
            dict[dto.id] = entity
        }
        return dict
    }

    private func syncProducts(
        _ dtos: [ProductDTO],
        categories: [Int: CategoryEntity],
        in context: NSManagedObjectContext
    ) {
        for dto in dtos {
            let entity = ProductEntity(context: context)
            entity.id = Int64(dto.id)
            entity.name = dto.name
            entity.price = dto.price
            entity.details = dto.details
            entity.imageUrl = dto.imageUrl
            entity.category = categories[dto.categoryId]
        }
    }

    private func syncOrders(
        _ dtos: [OrderDTO],
        in context: NSManagedObjectContext
    ) {
        for dto in dtos {
            let order = OrderEntity(context: context)
            order.id = Int64(dto.id)
            order.purchasedAt = dto.updatedAt
            order.totalAmount = dto.totalAmount
            order.paymentMethod = dto.paymentMethod.rawValue
            order.status = dto.status.rawValue

            for itemDto in dto.items ?? [] {
                let item = OrderItemEntity(context: context)
                item.id = Int64(itemDto.id)
                item.quantity = Int16(itemDto.quantity)
                item.price = itemDto.price
                item.order = order

                let request = ProductEntity.fetchRequest()
                let productId = Int64(itemDto.productId)
                request.predicate = NSPredicate(format: "id == %lld", productId)
                request.fetchLimit = 1

                do {
                    if let foundProduct = try context.fetch(request).first {
                        item.product = foundProduct
                    } else {
                        print("ERROR: CAN'T FIND PRODUCT WITH ID \(productId)")
                    }
                } catch {
                    print("ERROR: \(error)")
                }
            }
        }
    }
}
