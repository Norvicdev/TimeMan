//
//  CourseViewModel.swift
//  TimeMan
//
//  Created by Sai Ankit on 9/23/20.
//  Copyright © 2020 Sai Ankit. All rights reserved.
//

import SwiftUI

struct WeekDayName: Hashable, Identifiable {
    var name: String
    var id: String { name }
}

struct ClassTypeRepeat {
    var name: String
    var weekDays: Set<WeekDayName>
}

class CourseViewModel: ObservableObject {
    let weekDays : [WeekDayName] = [
        WeekDayName(name: "Monday"),
        WeekDayName(name: "Tuesday"),
        WeekDayName(name: "Wednesday"),
        WeekDayName(name: "Thursday"),
        WeekDayName(name: "Friday"),
        WeekDayName(name: "Saturday")
    ]
    
    let colorNumbers: [Color] = [
        Color(UIColor(hexString: "#7D83FD")),Color(UIColor(hexString: "#FF8E6E")),Color(UIColor(hexString: "#A5E17C")),Color(UIColor(hexString: "#FFDE41")),Color(UIColor(hexString: "#71EFBA")),Color(UIColor(hexString: "#EF7CE4")),Color(UIColor(hexString: "#84DBEE")),Color(UIColor(hexString: "#F5E0E0"))
    ]
    
    let colorNumbersLight: [Color] = [
    Color(UIColor(hexString: "#A1B0F5")),Color(UIColor(hexString: "#FFA68D")),Color(UIColor(hexString: "#B7F48D")),Color(UIColor(hexString: "#FFEA85")),Color(UIColor(hexString: "#84FFCB")),Color(UIColor(hexString: "#FF94F4")),Color(UIColor(hexString: "#9FEEFF")),Color(UIColor(hexString: "#F8EBEB"))
    ]
    
    let colorNames : [String] = [
        "Purple Punch", "Tangy Orange", "Placid Green", "Bright Yellow", "Trendy Teal", "Gleamy Pink", "Beaming Blue", "Vanilla Ice"
    ]
    // MARK: - Course
    @Published var courseTitle : String = ""
    @Published var courseCode : String = ""
    @Published var courseID : String = ""
    @Published var colorNum: Int = 0
    
    func generateLink(meetCode: String) -> String {
        let linkPreccedence = "https://meet.google.com/"
        return linkPreccedence + meetCode
    }
    
    // MARK: - Lecture
    @Published var lectureInstructorName : String = ""
    @Published var lectureNumber : Int = 1
    @Published var lectureTime = Date()
    @Published var lectureMeetCode: String = ""
    @Published var lectureRepeatWeek = ClassTypeRepeat(name: "", weekDays: [])
    @Published var isLectureExisting: Bool = true
    @Published var isLectureNotificationsEnabled: Bool = false
    func generateLectureNumber( lectureNumber: Int) -> String {
        return "L" + String(lectureNumber)
    }

    // MARK: - Tutorial
    @Published var tutorialInstructorName : String = ""
    @Published var tutorialNumber : Int = 1
    @Published var tutorialTime = Date()
    @Published var tutorialMeetCode: String = ""
    @Published var tutorialRepeatWeek = ClassTypeRepeat(name: "", weekDays: [])
    @Published var isTutorialExisting : Bool = false
    @Published var isTutorialNotificationsEnabled: Bool = false
    
    func generateTutorialNumber( tutorialNumber: Int) -> String {
        return "T" + String(tutorialNumber)
    }

    // MARK: - Practical
    @Published var practicalInstructorName : String = ""
    @Published var practicalNumber : Int = 1
    @Published var practicalTime = Date()
    @Published var practicalMeetCode: String = ""
    @Published var practicalRepeatWeek = ClassTypeRepeat(name: "", weekDays: [])
    @Published var isPracticalExisting : Bool = false
    @Published var isPracticalNotificationsEnabled: Bool = false
    func generatePracticalNumber( practicalNumber: Int) -> String {
        return "P" + String(practicalNumber)
    }
}
