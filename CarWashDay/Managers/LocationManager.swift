//
//  LocationManager.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/17/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // CLLocationManager 존재
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var location: CLLocation?
    // 위치 권한 상태를 저장함
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var address: String = "위치를 불러오는 중..."
    
    // NSObject가 objc 기반이라 init을 재정의
    override init() {
        super.init()
        // delegate 설정
        locationManager.delegate = self
        // 위치권한 설정
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트 시작..?
        locationManager.startUpdatingLocation()
    }
    
    // CLLocationManager가 새로운 위치 데이터를 수신할 때마다 호출됩니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            geocode(location: location)
        }
    }
    
    // 앱의 위치 서비스 권한 상태가 변경될 때 호출됨 -> 사용자가 위치 서비스 권한을 허가하거나 거부할 때 호출됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
    
    private func geocode(location: CLLocation) {
            geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ko_KR")) { (placemarks, error) in
                if let error = error {
                    self.address = "지오코딩 실패: \(error.localizedDescription)"
                } else if let placemark = placemarks?.first {
                    self.address = [
                        placemark.locality,
                        placemark.subLocality,
                    ].compactMap { $0 }.joined(separator: " ")
                }
            }
        }
}

