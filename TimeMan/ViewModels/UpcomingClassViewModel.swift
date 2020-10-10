//
//  UpcomingClassViewModel.swift
//  TimeMan
//
//  Created by Sai Ankit on 10/2/20.
//  Copyright © 2020 Sai Ankit. All rights reserved.
//

import SwiftUI

class UpcomingClassViewModel {
    @Environment(\.managedObjectContext) var managedObjectContext
    private let calendar = Calendar.current
    
    private func getClassType(course: Course) -> String {
        if course.isLecture {
            return course.lectureNumber!
        } else if course.isTutorial {
            return course.tutorialNumber!
        } else if course.isPractical {
            return course.practicalNumber!
        }
        return ""
    }
    
    private func shouldCourseBeIncluded(course: Course, index: Int) -> Bool {
        let weekDayName = longWeekDaySymbols[index]
        let converted = course.weekDayRepeat
        if converted!.contains(weekDayName) {
            return true
        }
        return false
    }
    
    private var errorCourse: Course {
        let errorCourse = Course(context: self.managedObjectContext)
        errorCourse.courseTitle = "No upcoming Classes"
        errorCourse.courseID = "E"
        errorCourse.courseCode = "E"
        errorCourse.instructorName = "E"
        errorCourse.weekDayRepeat = ["Monday"]
        errorCourse.meetLink = "E"
        errorCourse.lectureNumber = "E"
        errorCourse.tutorialNumber = "E"
        errorCourse.practicalNumber = "E"
        errorCourse.isLecture = true
        errorCourse.isTutorial = false
        errorCourse.isPractical = false
        errorCourse.lectureExists = true
        errorCourse.tutorialExists = true
        errorCourse.practicalExists = true
        errorCourse.time = Date()
        errorCourse.colorNum = 0
        
        return errorCourse
    }
    
    func getUpcomingClass(list: FetchedResults<Course>) -> Course {
        let listWork = list
        var upcomingCourse = Course()
        
        // Procedure followed to find the upcoming classes
        
        // We calculate the Current Time and Course Time in minutes
        // We find the difference between the Course Time and Current Time
        // Difference > 0 => Course Time is ahead of the Current Time
        // We loop across all the courses that are happening on the Current Day using the shouldCourseBeIncluded method
        // We find the minimum difference to find out which course is the upcoming course
        // We also make a note of the count variable which calculates if there are any upcoming classes or not
        // If the count == 0 then an error course is returned which indicates the nullity of upcoming classes
        
        let currentTimeHour = calendar.component(.hour, from: Date())
        let currentTimeMinute = calendar.component(.minute, from: Date())
        let currentTime = currentTimeHour * 60 + currentTimeMinute
        var minimumDifference = 1440
        var areUpcomingClassesAvailable = false
        let currentDayIndex = (Calendar.current.component(.weekday, from: Date())) - 1
        
        for courseClass in listWork {
            if shouldCourseBeIncluded(course: courseClass, index: currentDayIndex) {
                let courseClassTime = courseClass.time
                let courseHour = calendar.component(.hour, from: courseClassTime!)
                let courseMinute = calendar.component(.minute, from: courseClassTime!)
                let courseTime = courseHour * 60 + courseMinute
                let difference = courseTime - currentTime
                if difference > 0 {
                    if difference < minimumDifference {
                        minimumDifference = courseTime - currentTime
                        upcomingCourse = courseClass
                        areUpcomingClassesAvailable = true
                    }
                }
            }
        }
        
        if !areUpcomingClassesAvailable {
            return errorCourse
        }
        return upcomingCourse
    }
}
