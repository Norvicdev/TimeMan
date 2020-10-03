//
//  ContentView.swift
//  TimeMan
//
//  Created by Sai Ankit on 9/21/20.
//  Copyright © 2020 Sai Ankit. All rights reserved.
//

import SwiftUI
import UserNotifications
struct ContentView: View {
    @State var isPresented = false
    @State var selectedIndex = ""
    var body: some View {
        NavigationView {
                VStack {
                    if(selectedIndex == "Scroll") {
                        ScrollScreen(isPresented: $isPresented)
                    }
                    else if(selectedIndex == "") {
                        HomeScreen()
                    }
                    else {
                        GridScreen()
                    }
                TabBar(selectedTab: $selectedIndex, isPresented: $isPresented)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
