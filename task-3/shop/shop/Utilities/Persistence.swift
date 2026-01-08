//
//  Persistence.swift
//  shop
//
//  Created by Victoria Iashchuk on 11/12/2025.
//


import CoreData

struct JSONCategory: Decodable {
    let name: String
    let products: [JSONProduct]
}

struct JSONProduct: Decodable {
    let name: String
    let details: String
    let price: Double
    let imageName: String
}

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Shop")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        preloadData()
    }
    
    
    private func preloadData() {
        let context = container.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let count = try context.count(for: request)
            if count == 0 {
                seedInitialData(in: context)
            }
        } catch {
            print(error)
        }
    }
    
    private func seedInitialData(in context: NSManagedObjectContext) {
        guard let url = Bundle.main.url(forResource: "Fixtures", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("JSON not found")
            return
        }
        
        do {
            let decodedCategories = try JSONDecoder().decode([JSONCategory].self, from: data)
            
            for jsonCat in decodedCategories {
                let category = Category(context: context)
                category.id = UUID()
                category.name = jsonCat.name
                
                for jsonProd in jsonCat.products {
                    let product = Product(context: context)
                    product.id = UUID()
                    product.name = jsonProd.name
                    product.details = jsonProd.details
                    product.price = jsonProd.price
                    product.imageName = jsonProd.imageName
                    product.category = category
                }
            }
            
            try context.save()
            
        } catch {
            print(error)
        }
    }
    
}
