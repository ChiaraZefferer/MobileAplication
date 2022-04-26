//
//  projectApp.swift
//  project
//
//  Created by Zefferer Chiara on 25.04.22.
//

import SwiftUI

@main
struct projectApp: App {
    let slideManager = Slideservice()
    
    
    
    var body: some Scene {
        WindowGroup {
            ListOfSlidesView().environmentObject(slideManager)
            //ContentView()
        }
    }
}
