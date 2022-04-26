//
//  ListOfSlides.swift
//  project
//
//  Created by Zefferer Chiara on 26.04.22.
//

import SwiftUI
import MapKit
import CoreLocation

struct ListOfSlidesView: View {
    
    @State var home = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 47.43, longitude: 15.3
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
        )
    )
    
    @EnvironmentObject var sldMgr: Slideservice
    
    @StateObject var manager = CustomLocationManager()
    
    @State var followMe = true {
            willSet{
                print("Changing following mode... ")
            }
            didSet {
                // tracking mode works only, if permissions are granted
                // i.e. set permission in Info.plist

                print("We set the tacking mode to \(followMe).")
                trackingMode = followMe ? .follow : .none
            }
        }
        @State var trackingMode:MapUserTrackingMode = .none
    
    var body: some View {
        VStack{
            List(sldMgr.slides){
                slide in Text("\(slide.title)")
            }
                
            Text("In Simulator activate\nFeatures/Location/Freeway Drive").multilineTextAlignment(.center).padding()
                        Map(
                            coordinateRegion: $manager.region,
                            showsUserLocation: true,
                            
                            // tracking requires permissions in Info.plist !!
                            userTrackingMode: $trackingMode // .follow(=the map follows the user location) .none
                )
        }
        
    }
}

struct ListOfSlides_Previews: PreviewProvider {
    static var previews: some View {
        ListOfSlidesView()
    }
}



