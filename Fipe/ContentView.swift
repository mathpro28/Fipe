//
//  ContentView.swift
//  Fipe
//
//  Created by Mateo Mercado on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingForm = false
    @State private var selectedTeacher: String = "Juan Perez"  // Default selection
    @State private var selectedFlavor: Flavor = .rositas
    @State private var date = Date()
    @State private var currency: Decimal = 0.0
    
    // Dummy teacher data
    let teachers = ["Juan Perez", "Maria Lopez", "Carlos Gomez", "Ana Rodriguez"]

    enum Flavor: String, CaseIterable, Identifiable {
        case margaritas, rositas, arcoiris
        var id: Self { self }
    }

    var body: some View {
        NavigationView {
            VStack {
                Button("Add New Register") {
                    isShowingForm = true
                }
                .sheet(isPresented: $isShowingForm) {
                    RegularRegisterView()
                }
                .cornerRadius(50)
            }
            .navigationTitle("Main View")
        }
    }
}

#Preview {
    ContentView()
}
