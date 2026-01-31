//
//  CategoryList.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import SwiftUI

struct CategoryList: View {
    let categories: [CategoryEntity]
    
    @Binding var selectedCategory: CategoryEntity?
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    CategoryBadge(
                        name: "All",
                        isActive: selectedCategory == nil
                    ) {
                        selectedCategory = nil
                    }
                    
                    ForEach(categories) { category in
                        CategoryBadge(
                            name: category.name!,
                            isActive: selectedCategory?.id == category.id
                        ) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        }
    }
}
