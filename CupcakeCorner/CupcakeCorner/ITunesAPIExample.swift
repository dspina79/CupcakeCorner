//
//  ITunesAPIExample.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/26/20.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ITunesAPIExample: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: {
            loadData()
        })
    }
    
    func loadData() {
        guard let url = URL(string: "http://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                print("This is the data: \(data)")
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("There was an error: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ITunesAPIExample_Previews: PreviewProvider {
    static var previews: some View {
        ITunesAPIExample()
    }
}
