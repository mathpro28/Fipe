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
    @State var currency: Decimal = 0.0
    enum Flavor: String, CaseIterable, Identifiable {
        case margaritas, rositas, arcoiris
        var id: Self { self }
    }


    @State private var selectedFlavor: Flavor = .rositas
    
    var body: some View {
        NavigationView {
            Form {
                Section("Nombre del maestro") {
                    TextField("First name", text: $firstname)
                    TextField("Last name", text: $lastname)
                }
                
                Section("Grupo") {
                    Picker("Nombre del curso", selection: $selectedFlavor) {
                        Text("Margaritas").tag(Flavor.rositas)
                        Text("Rositas").tag(Flavor.rositas)
                        Text("Arcoiris").tag(Flavor.arcoiris)
                    }
                }
//                Section("Asistencia") {
//                    TextField()
//                }
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

#Preview {
    RegularRegisterView()
}
