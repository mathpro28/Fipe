//
//  CardsView.swift
//  Fipe
//
//  Created by Mateo Mercado on 5/9/24.
//

import SwiftUI
import RealmSwift

struct CardsView: View {
    // Fetch all items from Realm
    @ObservedResults(Item.self) var items
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(items, id: \.id) { item in
                        // Card for each item
                        ItemCardView(item: item)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Registro")
        }
    }
}

// Create a separate view for each item's card
struct ItemCardView: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Teacher:")
                    .font(.headline)
                Text(item.assignee?.teacherFullName ?? "Unknown")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Course:")
                    .font(.headline)
                Text(item.course?.courseName ?? "Unknown")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Quantity:")
                    .font(.headline)
                Text("\(item.qty)")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Total:")
                    .font(.headline)
                Text("\(item.total)")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Date:")
                    .font(.headline)
                Text(item.timestamp, style: .date)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    CardsView()
}
