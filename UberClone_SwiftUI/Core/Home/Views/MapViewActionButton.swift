//
//  MapViewActionButton.swift
//  UberClone_SwiftUI
//
//  Created by M H on 21/12/2022.
//

import SwiftUI

struct MapViewActionButton: View {
	
	@Binding var mapState: MapViewState
	@EnvironmentObject var vm: LocationSearchViewModel
	
    var body: some View {
		Button {
			withAnimation(.spring()) {
				actionForState(state: mapState)
			}
		} label: {
			Image(systemName: imageNameForState(state: mapState))
				.font(.title2)
				.foregroundColor(.black)
				.padding()
				.frame(width: 50, height: 50)
				.background(.white)
				.clipShape(Circle())
				.shadow(color: .black, radius: 6)
		}
		.frame(maxWidth: .infinity, alignment: .leading)

	}
	
	func actionForState(state: MapViewState) {
		switch state {
			case .noInput:
				print("DEBUG no input")
			case .searchingForLocation:
				mapState = .noInput
			case .locationSelected:
				mapState = .noInput
				vm.selectedLocationCoordinates = nil
		}
	}
	
	func imageNameForState(state: MapViewState) -> String {
		switch state {
			case .noInput:
				return "line.3.horizontal"
			case .searchingForLocation, .locationSelected:
				return "arrow.left"
		}
	}
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
		MapViewActionButton(mapState: .constant(.noInput))
    }
}
