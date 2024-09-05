//
//  ContentView.swift
//  Fipe
//
//  Created by Mateo Mercado on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingForm = false

    var body: some View {
        NavigationView {
            VStack {
                // Button with a system image
                HStack {
                    Spacer()
                    createNewSheet()
                }
                Text("Creating Dummy Data")
                    .onAppear {
                        createDummyData() // Call your function to create dummy data
                    }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func createNewSheet() -> some View {
        Button(action: {
            isShowingForm = true
        }) {
            Label("", systemImage: "plus")
                .padding()
        }
        .sheet(isPresented: $isShowingForm) {
            RegularRegisterView() // Display the form in a sheet
        }
    }
}

#Preview {
    ContentView()
}

