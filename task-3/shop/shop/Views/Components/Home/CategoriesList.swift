//
//  Categories.swift
//  shop
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI

struct CategoryList: View {
    let categories: FetchedResults<Category>
    
    @Binding var selectedCategory: Category?
    
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
                            name: category.name ?? "Secret category",
                            isActive: selectedCategory == category
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
