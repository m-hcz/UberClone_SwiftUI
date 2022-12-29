//
//  RideRequestView.swift
//  UberClone_SwiftUI
//
//  Created by M H on 23/12/2022.
//

import SwiftUI

struct RideRequestView: View {
	
	@State private var selectedRideType: RideType = .uverX
	
    var body: some View {
		VStack {
			Capsule()
				.foregroundColor(Color(.systemGray5))
				.frame(width: 48, height: 6)
				.padding()
			
			HStack {
				VStack {
					Circle()
						.fill(Color(.systemGray3))
						.frame(width: 8, height: 8)
					
					Rectangle()
						.fill(Color(.systemGray3))
						.frame(width: 1, height: 32)
					
					Rectangle()
						.fill(.primary)
						.frame(width: 8, height: 8)
				}
				
				VStack(alignment: .leading, spacing: 24) {
					HStack {
						Text("Current location")
						
						Spacer()
						
						Text("1:00 PM")
					}
					.padding(.bottom, 10)
					
					HStack {
						Text("Destination")
							.foregroundColor(.primary)
						
						Spacer()
						
						Text("2:00 PM")
					}
				}
				.foregroundColor(.gray)
				.font(.system(size: 16, weight: .semibold))
				.padding(.leading, 8)
				
			}
			.padding(.horizontal)
			
			Divider()
				.padding(.vertical)
			
			Text("SUGGESTED RIDES")
				.font(.subheadline)
				.fontWeight(.semibold)
				.foregroundColor(.gray)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.horizontal)
			
			ScrollView(.horizontal) {
				HStack(spacing: 20) {
					ForEach(RideType.allCases, id: \.self) { rideType in
						VStack(alignment: .leading) {
							Image(rideType.imageName)
								.resizable()
								.scaledToFit()
							
							VStackLayout(alignment: .leading, spacing: 4) {
								Text(rideType.description)
								
								Text("$22.04")
							}
							.padding()
								
								
						}
						.foregroundColor(rideType == selectedRideType ? .white : .black)
						.font(.system(size: 16, weight: .semibold))
						.frame(width: 112, height: 140)
						.scaleEffect(rideType == selectedRideType ? 1.1 : 1)
						.background(Color(rideType == selectedRideType ? .systemBlue : .systemGroupedBackground))
						.cornerRadius(10)
						.onTapGesture {
							withAnimation(.spring()) {
								selectedRideType = rideType
							}
						}
					}
				}
			}
			.padding(.horizontal)
			
			Divider()
				.padding(.vertical)
			
			HStack(spacing: 12) {
				Text("VISA")
					.font(.subheadline)
					.fontWeight(.semibold)
					.padding(6)
					.background(.blue)
					.cornerRadius(4)
					.foregroundColor(.white)
					.padding(.leading)
				
				Text("*** 1234")
					.fontWeight(.bold)
				
				Spacer()
				
				Image(systemName: "chevron.right")
					.imageScale(.medium)
					.padding()
			}
			.frame(height: 50)
			.background(Color(.systemGroupedBackground))
			.cornerRadius(10)
			.padding(.horizontal)
			
			Button {
				
			} label: {
				Text("CONFIRM RIDE")
					.fontWeight(.bold)
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(.blue)
					.cornerRadius(10)
					.foregroundColor(.white)
					.padding(.horizontal)
			}

		}
		.padding(.bottom, 30)
		.background(.white)
		.cornerRadius(16)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
