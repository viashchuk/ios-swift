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

            let categoryRequest = CategoryEntity.fetchRequest()
            categoryRequest.predicate = NSPredicate(
                format: "id == %lld",
                Int64(dto.id)
            )

            let category =
                (try? context.fetch(categoryRequest).first)
                ?? CategoryEntity(context: context)

            category.id = Int64(dto.id)
            category.name = dto.name
            dict[dto.id] = category
        }
        return dict
    }

    private func syncProducts(
        _ dtos: [ProductDTO],
        categories: [Int: CategoryEntity],
        in context: NSManagedObjectContext
    ) {
        for dto in dtos {

            let productRequest = ProductEntity.fetchRequest()
            productRequest.predicate = NSPredicate(
                format: "id == %lld",
                Int64(dto.id)
            )

            let product =
                (try? context.fetch(productRequest).first)
                ?? ProductEntity(context: context)

            product.id = Int64(dto.id)
            product.name = dto.name
            product.price = dto.price
            product.details = dto.details
            product.imageUrl = dto.imageUrl
            product.category = categories[dto.categoryId]
        }
    }

    private func syncOrders(
        _ dtos: [OrderDTO],
        in context: NSManagedObjectContext
    ) {
        for dto in dtos {
            let orderRequest = OrderEntity.fetchRequest()
            orderRequest.predicate = NSPredicate(
                format: "id == %lld",
                Int64(dto.id)
            )

            let order =
                (try? context.fetch(orderRequest).first)
                ?? OrderEntity(context: context)

            order.id = Int64(dto.id)
            order.purchasedAt = dto.updatedAt
            order.totalAmount = dto.totalAmount
            order.paymentMethod = dto.paymentMethod.rawValue
            order.status = dto.status.rawValue

            for itemDto in dto.items ?? [] {
                let itemRequest = OrderItemEntity.fetchRequest()
                itemRequest.predicate = NSPredicate(
                    format: "id == %lld",
                    Int64(itemDto.id)
                )

                let item =
                    (try? context.fetch(itemRequest).first)
                    ?? OrderItemEntity(context: context)
                item.id = Int64(itemDto.id)
                item.quantity = Int16(itemDto.quantity)
                item.price = itemDto.price
                item.order = order

                let productRequest = ProductEntity.fetchRequest()
                let productId = Int64(itemDto.productId)
                productRequest.predicate = NSPredicate(
                    format: "id == %lld",
                    productId
                )
                productRequest.fetchLimit = 1

                if let foundProduct = try? context.fetch(productRequest).first {
                    item.product =
                        context.object(with: foundProduct.objectID)
                        as? ProductEntity
                }
            }
        }
    }
}
