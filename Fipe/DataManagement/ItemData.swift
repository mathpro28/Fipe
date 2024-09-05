//
//  ItemData.swift
//  Fipe
//
//  Created by Mateo Mercado on 4/9/24.
//

import RealmSwift
import Foundation

func createDummyData() {
    // Get the default Realm
    let realm = try! Realm()

    // Begin a write transaction
    try! realm.write {
        // Create 5 teachers
        let teacher1 = Teacher(teacherID: UUID(), teacherName: "Miguel", teacherPhoneNumber: 74233064, teacherLastname: "Lopez")
        let teacher2 = Teacher(teacherID: UUID(), teacherName: "Maria", teacherPhoneNumber: 987654321, teacherLastname: "Lopez")
        let teacher3 = Teacher(teacherID: UUID(), teacherName: "Carlos", teacherPhoneNumber: 456123789, teacherLastname: "Gomez")
        let teacher4 = Teacher(teacherID: UUID(), teacherName: "Ana", teacherPhoneNumber: 321654987, teacherLastname: "Rodriguez")
        let teacher5 = Teacher(teacherID: UUID(), teacherName: "Luis", teacherPhoneNumber: 741852963, teacherLastname: "Martinez")

        // Add teachers to the Realm
        realm.add([teacher1, teacher2, teacher3, teacher4, teacher5])

        // Create 5 courses
        let course1 = Course(courseID: UUID(), courseName: "Margaritas")
        let course2 = Course(courseID: UUID(), courseName: "Rositas")
        let course3 = Course(courseID: UUID(), courseName: "Pre-juveniles")
        let course4 = Course(courseID: UUID(), courseName: "Biology")
        let course5 = Course(courseID: UUID(), courseName: "History")

        // Add courses to the Realm
        realm.add([course1, course2, course3, course4, course5])

        // Create 5 items and assign them to teachers and courses
        let item1 = Item(timestamp: Date(), qty: 10, total: Decimal128(100.50), assignee: teacher1, course: course1)
        let item2 = Item(timestamp: Date(), qty: 20, total: Decimal128(200.75), assignee: teacher2, course: course2)
        let item3 = Item(timestamp: Date(), qty: 15, total: Decimal128(150.25), assignee: teacher3, course: course3)
        let item4 = Item(timestamp: Date(), qty: 25, total: Decimal128(250.40), assignee: teacher4, course: course4)
        let item5 = Item(timestamp: Date(), qty: 30, total: Decimal128(300.90), assignee: teacher5, course: course5)

        // Add items to the Realm
        realm.add([item1, item2, item3, item4, item5])
    }
    
    print("Dummy data created successfully!")
}

func deleteDummyData() {
    // Get the default Realm
    let realm = try! Realm()

    // Begin a write transaction
    try! realm.write {
        // Fetch all the data for teachers, courses, and items
        let allTeachers = realm.objects(Teacher.self)
        let allCourses = realm.objects(Course.self)
        let allItems = realm.objects(Item.self)

        // Delete the data
        realm.delete(allItems)
        realm.delete(allCourses)
        realm.delete(allTeachers)
    }

    print("Dummy data deleted successfully!")
}


