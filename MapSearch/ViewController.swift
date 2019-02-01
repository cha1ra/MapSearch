//
//  ViewController.swift
//  MapSearch
//
//  Created by 坂尻愛明 on 2019/02/01.
//  Copyright © 2019 cha1ra.com. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    // 位置情報を取得するマネージャー
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let status = CLLocationManager.authorizationStatus()
//        if status == .authorizedWhenInUse {
//            print("俺やで！")
//            self.showMapDisplay()
//        }
        
        
        // delegete設定を追加
        self.searchBar.delegate = self
        self.locationManager.delegate = self
        
        // 位置情報取得するための認可をユーザーから取得
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    private func showMapDisplay() {
        print("showMapDisplay() was called.")
        //10m 移動するごとに取得
        self.locationManager.distanceFilter = 10
        //位置情報の取得を開始
        self.locationManager.startUpdatingLocation()
    }


}


extension ViewController: CLLocationManagerDelegate {
    
    // ユーザーから認可/不認可があった場合に呼び出される
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        //位置情報取得がOKの場合
        if status == .authorizedWhenInUse{
            //マップを表示
            self.showMapDisplay()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Mapの中心の定義
            let center = CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude)
            
            //表示範囲のち定義
            let span = MKCoordinateSpan(
                latitudeDelta: 0.02,
                longitudeDelta: 0.02)
            
            //マップの表示
            let region = MKCoordinateRegion(center: center, span: span)
            
            self.mapView.setRegion(region, animated:true)
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    //検索される時に呼び出される
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // キーボードを閉じる
        searchBar.resignFirstResponder()
        
        // 検索条件の作成
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBar.text
        
        // 検索範囲は現在のマップ表示内
        request.region = self.mapView.region
        
        // 周辺検索を開始
        let localSearch = MKLocalSearch(request: request)
        localSearch.start(completionHandler: {result, error in
            //検索結果を一つずつ処理
            if let result = result {
                for mapItem in result.mapItems {
                    // 検索した場所にピンを刺す
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(
                        latitude: mapItem.placemark.coordinate.latitude,
                        longitude: mapItem.placemark.coordinate.longitude
                    )
                    annotation.title = mapItem.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
        
    }
}

extension ViewControl
