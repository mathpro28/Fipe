//
//  FormsView.swift
//  Fipe
//
//  Created by Mateo Mercado on 3/9/24.
//

import SwiftUI
import RealmSwift

struct ManageTeachersView: View {
    @State private var showConfirmationAlert = false
    @State private var teacherName: String = ""  // For the teacher's first name
    @State private var teacherLastname: String = ""  // For the teacher's last name
    @State private var teacherPhoneNumber: String = ""  // For the teacher's phone number
    @State private var dateOfBirth = Date()

    @ObservedResults(Teacher.self) var teachers  // Fetch teachers from Realm
    
    var body: some View {
        NavigationView {
            if #available(iOS 17.0, *) {
                Form {
                    Section("Información del maestro") {
                        TextField("Nombre", text: $teacherName)  // Bind to teacherName state
                        TextField("Apellido", text: $teacherLastname)  // Bind to teacherLastname state
                        TextField("Teléfono", text: $teacherPhoneNumber)  // Bind to teacherPhoneNumber state
                            .keyboardType(.numberPad)
                        DatePicker(
                            "Fecha de nacimiento",
                            selection: $dateOfBirth,
                            displayedComponents: [.date]
                        )
                    }
                }
                .navigationTitle(Text("Nuevo Maestro"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        confirmButton()
                    }
                }
                .toolbarTitleDisplayMode(.inline)
            } else {
                // Fallback on earlier versions
            }
        }

    }
    
    // Function to save the teacher to Realm
    func saveTeacher() {
        // Convert phone number to integer
        guard let phoneNumber = Int(teacherPhoneNumber) else {
            print("Error: Invalid phone number format.")
            return
        }
        
        // Get the default Realm
        let realm = try! Realm()

        // Create a new Teacher object
        let newTeacher = Teacher(
            teacherID: UUID(),
            teacherName: teacherName,
            teacherPhoneNumber: phoneNumber, 
            teacherLastname: teacherLastname
        )
        
        // Begin write transaction
        try! realm.write {
            // Add the new teacher to the Realm
            realm.add(newTeacher)
        }

        // Show confirmation alert
        showConfirmationAlert = true
        print("Teacher saved successfully!")
    }
    
    func confirmButton() -> some View {
        return Button(action: saveTeacher) {
            Text("Confirmar")
        }
        .alert("Guardar Datos", isPresented: $showConfirmationAlert) {
            // Alert buttons
            Button("Confirmar", action: saveTeacher)  // Call saveTeacher when confirmed
            Button("Cancelar", role: .cancel, action: {})  // Cancel button with no action
        } message: {
            Text("¿Desea confirmar el registro del maestro?")
        }
    }
}

#Preview {
    ManageTeachersView()
}
