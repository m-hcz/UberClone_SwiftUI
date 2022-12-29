//
//  RideType.swift
//  UberClone_SwiftUI
//
//  Created by M H on 23/12/2022.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
	case uverX
	case black
	case uberXL
	
	var id: Int {return rawValue}
	
	var description: String {
		switch self {
			case .uverX: return "UberX"
			case .black: return "UberBlack"
			case .uberXL: return "UberXL"
		}
	}
	
	var imageName: String {
		switch self {
			case .uverX: return "uber-x"
			case .black: return "uber-black"
			case .uberXL: return "uber-x"
		}
	}
	
	var baseFare: Double {
		switch self {
			case .uverX: return 5
			case .black: return 20
			case .uberXL: return 10
		}
	}
	
	func computePrice(distanceInMeters: Double) -> Double {
		switch self {
			case .uverX: return distanceInMeters * 1.5 + baseFare
			case .black: return distanceInMeters * 2.0 + baseFare
			case .uberXL: return distanceInMeters * 1.75 + baseFare
		}
	}
}
