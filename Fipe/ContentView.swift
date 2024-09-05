//
//  ContentView.swift
//  Fipe
//
//  Created by Mateo Mercado on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingItemForm = false
    @State private var isShowingTeacherForm = false

    var body: some View {
        NavigationView {
            VStack {
                // Buttons with system images
                HStack {
                    Spacer()
                    createNewSheet()  // Button for new item
                    createNewTeacher() // Button for new teacher
                }
                Spacer()
//                CardsView()  // You can uncomment this when you add the CardsView
            }
            .onAppear {
                deleteDummyData()
//                createDummyData()  Call your function to create dummy data
            }
        }
    }
    
    @ViewBuilder
    func createNewSheet() -> some View {
        Button(action: {
            isShowingItemForm = true  // Set the @State variable directly
        }) {
            Label("", systemImage: "plus")
                .padding()
        }
        .sheet(isPresented: $isShowingItemForm) {
            RegularRegisterView() // Display the form in a sheet
        }
    }
    
    @ViewBuilder
    func createNewTeacher() -> some View {
        Button(action: {
            isShowingTeacherForm = true  // Set the @State variable directly
        }) {
            Label("", systemImage: "person.badge.plus")
                .padding()
        }
        .sheet(isPresented: $isShowingTeacherForm) {
            ManageTeachersView() // Display the form in a sheet
        }
    }
}

#Preview {
    ContentView()
}
