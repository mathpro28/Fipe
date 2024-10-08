//
//  FormsView.swift
//  Fipe
//
//  Created by Mateo Mercado on 3/9/24.
//

import SwiftUI
import RealmSwift

struct RegularRegisterView: View {
    @State private var showConfirmationAlert = false
    @State private var date = Date()
    @State private var currency: Decimal = 0.0
    @State private var selectedTeacher: String = ""  // Selection will be based on Teacher's name
    @State private var selectedCourse: String = ""
    @State private var qty: Int = 0  // State variable to store the quantity
    
    @ObservedResults(Teacher.self) var teachers  // Fetch real teachers from Realm
    @ObservedResults(Course.self) var courses    // Fetch real courses from Realm
    
    var body: some View {
        NavigationView {
            VStack {
                if #available(iOS 17.0, *) {
                    Form {
                        Section("Maestro") {
                            Picker("Nombre del maestro", selection: $selectedTeacher) {
                                ForEach(teachers, id: \.teacherFullName) { teacher in
                                    Text(teacher.teacherFullName).tag(teacher.teacherFullName)
                                }
                            }
                        }
                        
                        Section("Grupo") {
                            Picker("Nombre del curso", selection: $selectedCourse) {
                                ForEach(courses, id: \.courseName) { course in
                                    Text(course.courseName).tag(course.courseName)
                                }
                            }
                        }
                        
                        Section("Asistentes") {
                            Stepper(value: $qty, in: 0...100) {  // Connect Stepper to qty state variable
                                Text("Numero de asistentes: \(qty)")  // Display the quantity
                            }
                        }
                        
                        Section("Fecha") {
                            DatePicker(
                                "Fecha de registro",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                        }
                        
                        Section("Ofrenda") {
                            TextField("Monto", value: $currency, format: .currency(code: "BOB"))
                                .keyboardType(.decimalPad)
                        }
                    }
                    .navigationTitle(Text("Nuevo Registro"))
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
    }
    
    // Function to save the item to Realm
    func saveItem() {
        // Get the default Realm
        let realm = try! Realm()
        
        // Find the selected teacher and course
        let selectedTeacherParts = selectedTeacher.split(separator: " ")
        
        guard selectedTeacherParts.count >= 2 else {
            print("Error: Could not parse teacher name and last name.")
            return
        }
        
        let firstName = String(selectedTeacherParts[0])
        let lastName = String(selectedTeacherParts[1])
        
        guard let selectedTeacherObject = realm.objects(Teacher.self)
                .filter("teacherName == %@ AND teacherLastname == %@", firstName, lastName).first,
              let selectedCourseObject = realm.objects(Course.self).filter("courseName == %@", selectedCourse).first else {
            print("Error: Could not find teacher or course.")
            return
        }

        // Create a new item
        let newItem = Item(timestamp: Date(), qty: qty, total: Decimal128(value: currency), assignee: selectedTeacherObject, course: selectedCourseObject)
        
        // Begin write transaction
        try! realm.write {
            // Add new item to the Realm
            realm.add(newItem)
        }

        // Confirmation alert
        showConfirmationAlert = true
        print("Item saved successfully!")
    }

    func confirmButton() -> some View {
        Button(action: {
            showConfirmationAlert = true
        }) {
            Text("Confirmar")
        }
        .alert("Guardar Datos", isPresented: $showConfirmationAlert) {
            // Alert buttons
            Button("Confirmar", action: saveItem)  // Call saveItem when confirmed
            Button("Cancelar", role: .cancel, action: {})  // Cancel button with no action
        } message: {
            Text("Desea confirmar el registro?")
        }
    }

}

#Preview {
    RegularRegisterView()
}
