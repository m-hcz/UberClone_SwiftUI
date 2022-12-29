//
//  LocationSearchViewModel.swift
//  UberClone_SwiftUI
//
//  Created by M H on 22/12/2022.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
// MARK: props
	@Published var results = [MKLocalSearchCompletion]()
	@Published var selectedLocationCoordinates: CLLocationCoordinate2D? = nil
	
	private let searchCompleter = MKLocalSearchCompleter()
	var queryFragment: String = "" {
		didSet {
			searchCompleter.queryFragment = queryFragment
		}
	}
	
	override init() {
		super.init()
		searchCompleter.delegate = self
		searchCompleter.queryFragment = queryFragment
	}
	
	// MARK: func
	func selectLocation (localSearch: MKLocalSearchCompletion) {
		locationSearch(forLocalSearchCompletion: localSearch) { response, error in
			if let error = error {
				print("Error: \(error.localizedDescription)")
				return
			}
			
			guard let item = response?.mapItems.first else {return}
			let coordinate = item.placemark.coordinate
			self.selectedLocationCoordinates = coordinate
			
			print("DEBUG coordinate: \(coordinate)")
		}
	}
	
	private func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
		let searchRequest = MKLocalSearch.Request()
		searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
		let search = MKLocalSearch(request: searchRequest)
		search.start(completionHandler: completion)
	}
}

// MARK: delegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		self.results = completer.results
	}
}
