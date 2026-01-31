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
            guard let lastSync = UserDefaults.standard.object(forKey: lastSyncKey) as? Date else {
                return true
            }
            return Date().timeIntervalSince(lastSync) > cacheExpiration
        }
    

    func syncEverything(from response: SyncResponse) {
        container.performBackgroundTask { context in
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            do {
                let categoryEntities = self.syncCategories(response.categories, in: context)
                
                self.syncProducts(response.products, categories: categoryEntities, in: context)
            
//                self.syncOrders(response.orders, in: context)
                
                try context.save()
                
                UserDefaults.standard.set(Date(), forKey: self.lastSyncKey)
                print("SYNC DONE")
                
            } catch {
                print("SYNC ERROR: \(error)")
            }
        }
    }

    private func syncCategories(_ dtos: [CategoryDTO], in context: NSManagedObjectContext) -> [Int: CategoryEntity] {
        var dict = [Int: CategoryEntity]()
        for dto in dtos {
            let entity = CategoryEntity(context: context)
            entity.id = Int64(dto.id)
            entity.name = dto.name
            dict[dto.id] = entity
        }
        return dict
    }

    private func syncProducts(_ dtos: [ProductDTO], categories: [Int: CategoryEntity], in context: NSManagedObjectContext) {
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

    private func syncOrders(_ dtos: [OrderDTO], in context: NSManagedObjectContext) {
        for dto in dtos {
            let order = OrderEntity(context: context)
            order.id = Int64(dto.id)
            order.purchasedAt = dto.updatedAt
//            order.paymentMethod = dto.paymentMethod
//            order.status = dto.status
            
            for itemDto in dto.items {
                let item = OrderItemEntity(context: context)
                item.id = Int64(itemDto.id)
                item.quantity = Int16(itemDto.quantity)
                item.price = itemDto.price
                item.order = order
            }
        }
    }
}
