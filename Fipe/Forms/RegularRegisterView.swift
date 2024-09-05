//
//  FormsView.swift
//  Fipe
//
//  Created by Mateo Mercado on 3/9/24.
//

import SwiftUI

struct RegularRegisterView: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var clase: String = ""
    @State private var date = Date()
    @State private var currency: Decimal = 0.0
    @State private var selectedTeacher: String = "Juan Perez"  // Default selection
    
    enum Flavor: String, CaseIterable, Identifiable {
        case margaritas, rositas, arcoiris
        var id: Self { self }
    }

    @State private var selectedFlavor: Flavor = .rositas

    // Dummy teacher data
    let teachers = ["Juan Perez", "Maria Lopez", "Carlos Gomez", "Ana Rodriguez"]

    var body: some View {
        NavigationView {
            ZStack {
//                HStack {
//                    Spacer()
//                    Text("Confirm")
//                }
//                .padding()
                
                Form {
                    Section("Maestro") {
                        Picker("Nombre del maestro", selection: $selectedTeacher) {
                            ForEach(teachers, id: \.self) { teacher in
                                Text(teacher).tag(teacher)
                            }
                        }
                    }
                    
                    Section("Grupo") {
                        Picker("Nombre del curso", selection: $selectedFlavor) {
                            Text("Margaritas").tag(Flavor.margaritas)
                            Text("Rositas").tag(Flavor.rositas)
                            Text("Arcoiris").tag(Flavor.arcoiris)
                        }
                    }

                    Section("Fecha") {
                        DatePicker(
                            "Fecha de registro",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                    }
                    Section("Ofrenda"){
                        TextField("Monto", value: $currency, format: .currency(code: "BOB"))
                    }
                }
                .navigationTitle(Text("Nuevo Registro"))
            }
        }
    }
}

#Preview {
    RegularRegisterView()
}
