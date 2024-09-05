//
//  Register.swift
//  Fipe
//
//  Created by Mateo Mercado on 2/9/24.
//

import RealmSwift
import Foundation

// Item Model
class Item: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var timestamp: Date
    @Persisted var qty: Int
    @Persisted var total: Decimal128
    @Persisted var assignee: Teacher?
    @Persisted var course: Course?

    convenience init(timestamp: Date, qty: Int, total: Decimal128, assignee: Teacher, course: Course) {
        self.init()
        self.timestamp = timestamp
        self.qty = qty
        self.total = total
        self.assignee = assignee
        self.course = course
    }
}

// Teacher Model
class Teacher: Object, Identifiable {
    @Persisted(primaryKey: true) var teacherID: UUID
    @Persisted var teacherName: String
    @Persisted var teacherLastname: String
    @Persisted var teacherPhoneNumber: Int

    var teacherFullName: String {
        return "\(teacherName) \(teacherLastname)"
    }

    @Persisted(originProperty: "assignee") var items: LinkingObjects<Item>

    convenience init(teacherID: UUID, teacherName: String, teacherPhoneNumber: Int, teacherLastname: String) {
        self.init()
        self.teacherID = teacherID
        self.teacherName = teacherName
        self.teacherPhoneNumber = teacherPhoneNumber
        self.teacherLastname = teacherLastname
    }
}

// Course Model
class Course: Object, Identifiable {
    @Persisted(primaryKey: true) var courseID: UUID
    @Persisted var courseName: String

    @Persisted(originProperty: "course") var items: LinkingObjects<Item>

    convenience init(courseID: UUID, courseName: String) {
        self.init()
        self.courseID = courseID
        self.courseName = courseName
    }
}

