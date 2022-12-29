//
//  LocationSearchView.swift
//  UberClone_SwiftUI
//
//  Created by M H on 22/12/2022.
//

import SwiftUI

struct LocationSearchView: View {
	
	@State private var starLocationText = ""
	@Binding var mapState: MapViewState
	@EnvironmentObject var vm: LocationSearchViewModel
	
    var body: some View {
		VStack {
			// header view
			HStack {
				VStack {
					Circle()
						.fill(Color(.systemGray3))
						.frame(width: 6, height: 6)
					
					Rectangle()
						.fill(Color(.systemGray3))
						.frame(width: 1, height: 24)
					
					Rectangle()
						.fill(.primary)
						.frame(width: 6, height: 6)
				}
				
				VStack {
					TextField("Current location", text: $starLocationText)
						.frame(height: 32)
						.background(
							Color(.systemGroupedBackground)
						)
					TextField("Where to?", text: $vm.queryFragment)
						.frame(height: 32)
						.background(
							Color(.systemGray4)
						)
						
				}
			}
			.padding(.horizontal)
			.padding(.top, 64)
			
			Divider()
				.padding(.vertical)
			
			// list view
			ScrollView {
				VStack(alignment: .leading) {
					ForEach(vm.results, id: \.self) { result in
						LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
							.onTapGesture {
								withAnimation(.spring()) {
									vm.selectLocation(localSearch: result)
									mapState = .locationSelected
								}
							}
					}
				}
			}
		}
		.background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
		LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
