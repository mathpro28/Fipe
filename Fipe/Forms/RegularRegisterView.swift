//
//  FormsView.swift
//  Fipe
//
//  Created by Mateo Mercado on 3/9/24.
//

import SwiftUI
import RealmSwift

struct RegularRegisterView: View {
    @State private var date = Date()
    @State private var currency: Decimal = 0.0
    @State private var selectedTeacher: String = ""
    @State private var selectedCourse: String = ""
    @ObservedResults(Teacher.self) var teachers
    @ObservedResults(Course.self) var courses

    var body: some View {
        NavigationView {
            ZStack {
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

                    Section("Fecha") {
                        DatePicker(
                            "Fecha de registro",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                    }

                    Section("Ofrenda") {
                        TextField("Monto", value: $currency, format: .currency(code: "BOB"))
                    }
                }
                .navigationTitle(Text("Nuevo Registro"))
            }
        }
        .onAppear {
            if let firstTeacher = teachers.first {
                selectedTeacher = firstTeacher.teacherFullName
            }
            if let firstCourse = courses.first {
                selectedCourse = firstCourse.courseName
            }
        }
    }
}

#Preview {
    RegularRegisterView()
}
