//
//  CourseInput.swift
//  TimeMan
//
//  Created by Sai Ankit on 9/22/20.
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

struct CourseInput: View {
    let weekDays : [WeekDayName] = [
        WeekDayName(name: "Monday"),
        WeekDayName(name: "Tuesday"),
        WeekDayName(name: "Wednesday"),
        WeekDayName(name: "Thursday"),
        WeekDayName(name: "Friday"),
        WeekDayName(name: "Saturday")
    ]
    @ObservedObject var viewModel: CourseViewModel = CourseViewModel()
    @State var isTutorialExisting : Bool = false
    @State var isPracticalExisting : Bool = false
    @State var isLectureExisting: Bool = false
    @State var lectureRepeatWeek = ClassTypeRepeat(name: "", weekDays: [])
    @State var tutorialRepeatWeek = ClassTypeRepeat(name: "", weekDays: [])
    @State var practicalRepeatWeek = ClassTypeRepeat(name: "", weekDays: [])
    @Binding var isPresented: Bool
    @Binding var coursesList: [Course]
    private func getTime(time : Date) -> String {
        var timeType: String = "AM"
        var hour: Int = (Calendar.current.component(.hour, from: time))
        let minute: Int = (Calendar.current.component(.minute, from: time))
        timeType = hour >= 12 ? "PM" : "AM"
        hour = hour > 12 ? hour - 12 : hour
        return String(hour) + ":" + String(minute) + " " + timeType
    }
    private func addCourse(course: Course)
    {
        coursesList.append(course)
    }
    var body: some View {
        NavigationView{
        Form{
            Section(header: Text("Course Information")){
                TextField("Course Title ( Digital Design )", text: $viewModel.courseTitle)
                
                TextField("Course Code ( ECE )", text: $viewModel.courseCode)
                
                TextField("Course ID ( F215 )", text: $viewModel.courseID)
            }
            // MARK: - Lecture
            Toggle(isOn: $isLectureExisting)
            {
                Text("Lecture")
            }
            if(self.isLectureExisting)
            {
                Section(header: Text("Lecture Information")){
                
                TextField("Lecture Instructor", text: $viewModel.lectureInstructorName)
                Stepper(value: $viewModel.lectureNumber, in: 1...10){
                    Text("L" + String(viewModel.lectureNumber))
                }
                DatePicker("Lecture Time", selection: $viewModel.lectureTime, displayedComponents: .hourAndMinute)
                TextField("Lecture Meet Link", text: $viewModel.lectureMeetLink)
                MultiSelector(
                    label: Text("WeekDay Repeat"),
                    options: weekDays,
                    optionToString: { $0.name },
                    selected: $lectureRepeatWeek.weekDays
                )
            }
            }
            
            
            // MARK: - Tutorial
            Toggle(isOn: $isTutorialExisting)
            {
                Text("Tutorial")
            }
            if(self.isTutorialExisting)
            {
                Section(header: Text("Tutorial Information")){
                    TextField("Tutorial Instructor", text: $viewModel.tutorialInstructorName)
                    Stepper(value: $viewModel.tutorialNumber, in: 1...10){
                        Text("T" + String(viewModel.tutorialNumber))
                                  }
                    DatePicker("Tutorial Time", selection: $viewModel.tutorialTime, displayedComponents: .hourAndMinute)
                    TextField("Tutorial Meet Link", text: $viewModel.tutorialMeetLink)
                    MultiSelector(
                        label: Text("WeekDay Repeat"),
                        options: weekDays,
                        optionToString: { $0.name },
                        selected: $tutorialRepeatWeek.weekDays
                    )
                    
                }
            }
            
            
            // MARK: - Practical
            Toggle(isOn: $isPracticalExisting)
            {
                Text("Practical")
            }
            if(self.isPracticalExisting)
            {
                Section(header: Text("Practical Information")){
                    TextField("Practical Instructor", text: $viewModel.practicalInstructorName)
                    Stepper(value: $viewModel.practicalNumber, in: 1...10){
                        Text("P" + String(viewModel.practicalNumber))
                                  }
                    DatePicker("Practical Time", selection: $viewModel.practicalTime, displayedComponents: .hourAndMinute)
                    TextField("Practical Meet Link", text: $viewModel.practicalMeetLink)
                    MultiSelector(
                        label: Text("WeekDay Repeat"),
                        options: weekDays,
                        optionToString: { $0.name },
                        selected: $practicalRepeatWeek.weekDays
                    )
                }
            }
            Section {
                Button(action:{
                    let mappedLectureRepeatWeek = lectureRepeatWeek.weekDays.map { $0.name }
                    let mappedTutorialRepeatWeek = tutorialRepeatWeek.weekDays.map { $0.name }
                    let mappedPracticalRepeatWeek = practicalRepeatWeek.weekDays.map { $0.name }
                    
                    
                    let newLecture = Course(id: ( coursesList.count + 1 ) ,courseTitle: viewModel.courseTitle, courseCode: viewModel.courseCode, courseID: viewModel.courseID, instructorName: viewModel.lectureInstructorName, time: viewModel.lectureTime, weekDayRepeat: mappedLectureRepeatWeek, meetLink: viewModel.lectureMeetLink, lectureNumber: "L" + String(viewModel.lectureNumber), tutorialNumber: "T" + String(viewModel.tutorialNumber), practicalNumber: " P" + String(viewModel.practicalNumber), isLecture: true, isTutorial: false, isPractical: false, tutorialExists: isTutorialExisting, practicalExits: isPracticalExisting, lectureExists: isLectureExisting)
                    
                    let newTutorial = Course(id: ( coursesList.count + 2 ) ,courseTitle: viewModel.courseTitle, courseCode: viewModel.courseCode, courseID: viewModel.courseID, instructorName: viewModel.tutorialInstructorName, time: viewModel.tutorialTime, weekDayRepeat: mappedTutorialRepeatWeek, meetLink: viewModel.tutorialMeetLink, lectureNumber: "L" + String(viewModel.lectureNumber), tutorialNumber: "T" + String(viewModel.tutorialNumber), practicalNumber: " P" + String(viewModel.practicalNumber), isLecture: false, isTutorial: true, isPractical: false, tutorialExists: isTutorialExisting, practicalExits: isPracticalExisting, lectureExists: isLectureExisting)
                    
                    let newPractical = Course(id: ( coursesList.count + 3 ) ,courseTitle: viewModel.courseTitle, courseCode: viewModel.courseCode, courseID: viewModel.courseID, instructorName: viewModel.practicalInstructorName, time: viewModel.practicalTime, weekDayRepeat: mappedPracticalRepeatWeek, meetLink: viewModel.practicalMeetLink, lectureNumber: "L" + String(viewModel.lectureNumber), tutorialNumber: "T" + String(viewModel.tutorialNumber), practicalNumber: " P" + String(viewModel.practicalNumber), isLecture: false, isTutorial: false, isPractical: true, tutorialExists: isTutorialExisting, practicalExits: isPracticalExisting, lectureExists: isLectureExisting)
                    
                    if(isLectureExisting)
                    {
                        addCourse(course: newLecture)
                    }
                    if(isTutorialExisting)
                    {
                        addCourse(course: newTutorial)
                    }
                    if(isPracticalExisting)
                    {
                        addCourse(course: newPractical)
                    }
                    self.isPresented.toggle()
                }){
                Text("Add Course")
              }
            }
            
        }.navigationBarTitle(Text("Add Course"),displayMode: .inline)
        }
    }
    
}
struct CourseInput_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
