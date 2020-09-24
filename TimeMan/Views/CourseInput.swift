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

struct Task {
    var name: String
    var servingGoals: Set<WeekDayName>
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
    @State var task = Task(name: "", servingGoals: [])
  
    var body: some View {
        Form{
            Section(header: Text("Course Information")){
                TextField("Course Title ( Digital Design )", text: $viewModel.courseTitle)
                
                TextField("Course Code ( ECE )", text: $viewModel.courseCode)
                
                TextField("Course ID ( F215 )", text: $viewModel.courseID)
            }
            // MARK: - Lecture
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
                    selected: $task.servingGoals
                )
                
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
                }
            }
        }.padding()
    }
}

struct CourseInput_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
