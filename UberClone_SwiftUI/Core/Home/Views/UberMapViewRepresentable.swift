//
//  UberMapViewRepresentable.swift
//  UberClone_SwiftUI
//
//  Created by M H on 21/12/2022.
//

import Foundation
import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
	let mapView = MKMapView()
	let locationMAnager = LocationManager.shared
	@Binding var mapState: MapViewState
	
	@EnvironmentObject var vm: LocationSearchViewModel
	
	func makeUIView(context: Context) -> some UIView {
		mapView.delegate = context.coordinator
		mapView.isRotateEnabled = false
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
		
		return mapView
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		
		switch mapState {
			case .noInput:
				context.coordinator.clearMapViewandRecenterOnUserLocation()
			case .searchingForLocation:
				break
			case .locationSelected:
				if let coordinate = vm.selectedLocationCoordinates {
					//print("DEBUG: selectedLocation: \(coordinate)")
					context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
					context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
				}
		}
	}
	
	func makeCoordinator() -> (MapCoordinator) {
		return MapCoordinator(parent: self)
	}
}


extension UberMapViewRepresentable {
	class MapCoordinator: NSObject, MKMapViewDelegate {
		let parent: UberMapViewRepresentable
		var userLocationCoordinate: CLLocationCoordinate2D?
		var currentRegion: MKCoordinateRegion?
		
		init(parent: UberMapViewRepresentable) {
			self.parent = parent
			super.init()
		}
		
		// MARK: delegate
		func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
			self.userLocationCoordinate = userLocation.coordinate
			
			let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
			self.currentRegion = region
			
			parent.mapView.setRegion(region, animated: true)
		}
		
		func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
			let polyline = MKPolylineRenderer(overlay: overlay)
			polyline.strokeColor = .systemBlue
			polyline.lineWidth = 6
			return polyline
		}
		
		// MARK: func
		func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
			parent.mapView.removeAnnotations(parent.mapView.annotations)
			
			let anno = MKPointAnnotation()
			anno.coordinate = coordinate
			parent.mapView.addAnnotation(anno)
			parent.mapView.selectAnnotation(anno, animated: true)
			
//			parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
		}
		func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
			guard let userLocationCoordinate = userLocationCoordinate else {return}
			
			getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
				self.parent.mapView.addOverlay(route.polyline)
				let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
				self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
			}
		}
		
		func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> ()) {
			let userPlacemark = MKPlacemark(coordinate: userLocation)
			let destPlacemark = MKPlacemark(coordinate: destination)
			let request = MKDirections.Request()
			request.source = MKMapItem(placemark: userPlacemark)
			request.destination = MKMapItem(placemark: destPlacemark)
			
			let directions = MKDirections(request: request)
			
			directions.calculate { response, error in
				if let error = error {
					print("Error: \(error.localizedDescription)")
					return
				}
				
				guard let route = response?.routes.first else {return}
				completion(route)
			}
		}
		
		func clearMapViewandRecenterOnUserLocation() {
			parent.mapView.removeAnnotations(parent.mapView.annotations)
			parent.mapView.removeOverlays(parent.mapView.overlays)
			
			if let currentRegion = currentRegion {
				parent.mapView.setRegion(currentRegion, animated: true)
			}
		}
		
	}
}
