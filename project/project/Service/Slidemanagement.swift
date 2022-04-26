//
//  Slidemanagement.swift
//  project
//
//  Created by Zefferer Chiara on 25.04.22.
//

import Foundation
import SwiftUI


enum WSError:Error{
    case invalidURL
    case notImplemented
    case urlNotSpecifiedInInfoPList
    case statusCodeNot200
    case jsonDecodingError
}
class Slideservice: ObservableObject {
    var slides: [Slide] = []
    
    func fetchSlides() async throws -> [Slide]{
        //urlString -> URL
        guard let wsUrlSt = Bundle.main.object(forInfoDictionaryKey: "WebServiceURL") as? String
        else{
            print("Err: Specify/check url string for key 'WebServiceURL'.")
            throw WSError.urlNotSpecifiedInInfoPList
        }
        guard let wsUrl = URL(string: wsUrlSt)
        else {
            print("Err: check url string")
            throw WSError.invalidURL
        }
        print("Loading from \(wsUrl)")
        let urlReq = URLRequest(url: wsUrl)
        let (data, resp) = try await URLSession.shared.data(for: urlReq)
        
        guard (resp as? HTTPURLResponse)?.statusCode == 200
        else {
            print("Err: we expect code 200. Check Ws.. .")
            throw WSError.statusCodeNot200
        }
        
        print("We got \(data). This is string : \( String.init(data:data, encoding: .utf8) ?? "Sorry, this is not UTF-8 string" )")
        //JSON -> inmemory obj:
        let decoder = JSONDecoder()
        guard let slideshow = try? decoder.decode(Slideshow.self, from: data)
        else {
            print("Err: could not decode data to slideshow. Check JSON on Server")
            throw WSError.jsonDecodingError
        }
        print("We got slideshow: \(slideshow.title)")
        
        for slide in slideshow.slides{
            print("\(slide)")
        }
        
        //throw WSError.notImplemented
        return slideshow.slides
    }
    
    init (){
        Task{
            print("Loading slides in the background")
            
            let fetchSlides = try? await fetchSlides()
            if let fs = fetchSlides{
                slides.append(contentsOf: fs)
            }
        }
    }
}
