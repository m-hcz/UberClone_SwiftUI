//
//  UberClone_SwiftUIApp.swift
//  UberClone_SwiftUI
//
//  Created by M H on 21/12/2022.
//

import SwiftUI

@main
struct UberClone_SwiftUIApp: App {
	
	@StateObject var locationVM = LocationSearchViewModel()
	
    var body: some Scene {
        WindowGroup {
			HomeView()
				.environmentObject(locationVM)
        }
    }
}
