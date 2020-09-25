//
//  CalendarItem.swift
//  TimeMan
//
//  Created by Sai Ankit on 9/22/20.
//  Copyright © 2020 Sai Ankit. All rights reserved.
//

import SwiftUI
struct CalendarItem: View{
    
    var isSelected: Bool
    var weekDay: String
    var body: some View{
        VStack {
            Text(self.weekDay)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
        }
        .frame(width: 40, height: 40)
        .padding([.vertical],20)
        .padding([.horizontal],15)
        .background(isSelected ? Color(#colorLiteral(red: 0.7912799716, green: 1, blue: 0.8202505708, alpha: 1)) : Color.white)
        .foregroundColor(weekDaySymbols[(Calendar.current.component(.weekday, from: Date()) - 2)] == weekDay ? Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)) : Color.white)
        .cornerRadius(25)
    }
}

struct CalendarItem_Previews: PreviewProvider {
    static var previews: some View {
        CalendarItem(isSelected: true, weekDay: "Wed")
    }
}
