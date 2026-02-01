//
//  CartRow.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import Combine
import CoreData
import SwiftUI

struct CartRow: View {
    @ObservedObject var item: OrderItemEntity
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                if let imageName = item.product?.imageUrl, !imageName.isEmpty {
                    AsyncImage(
                        url: URL(string: Constants.baseServerURL + imageName)
                    ) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.secondary.opacity(0.1))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "cup.and.saucer")
                                    .foregroundColor(.gray)
                            )
                    }
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondary.opacity(0.1))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "cup.and.saucer").foregroundColor(
                                .gray
                            )
                        )
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.product?.name ?? "Coffee")
                        .font(.headline)

                    Text("\(item.product?.price ?? 0, specifier: "%.2f") $")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                QuantityStepper(
                    quantity: Binding(
                        get: { Int(item.quantity) },
                        set: { newValue in
                            item.quantity = Int16(newValue)

                            do {
                                try item.managedObjectContext?.save()
                                appViewModel.refreshCart()
                            } catch {
                                print("ERROR STEPPER: \(error)")
                            }
                        }
                    )
                )
            }
            .padding(.vertical, 16)

            Divider()
        }
    }
}
