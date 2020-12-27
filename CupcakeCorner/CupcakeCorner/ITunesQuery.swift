//
//  ITunesQuery.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/26/20.
//

import SwiftUI

struct QueryResponse: Codable {
    var results: [QueryResult]
}

struct QueryResult: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ITunesQuery: View {
    @State private var query: String = ""
    @State private var results = [QueryResult]()
    @State private var noResults = false
    var body: some View {
        Form {
            Section {
                TextField("Artist Name", text: $query)
                Button("Search") {
                    loadData()
                }.disabled(query.isEmpty)
            }
            Section {
                List(results, id: \.trackId) { item in
                    VStack(alignment: .leading) {
                        Text(item.trackName)
                            .font(.headline)
                        Text(item.collectionName)
                            .font(.subheadline)
                    }
                }
            }
        }.alert(isPresented: $noResults) {
            Alert.init(title: Text("Query Error"), message: Text("No results found."), dismissButton: Alert.Button.default(Text("Ok")))
        }
        
    }
    
    func loadData() {
        let queryValue = query.replacingOccurrences(of: " ", with: "+")
        let urlQuery = "https://itunes.apple.com/search?term=.\(queryValue)&entity=song"
        
        guard let url = URL(string: urlQuery) else {
            print("Valid URL not provided.")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let responseData = data {
                if let decodedValue = try? JSONDecoder().decode(QueryResponse.self, from: responseData) {
                    DispatchQueue.main.async {
                        self.results = decodedValue.results
                        if self.results.count == 0 {
                            self.noResults = true
                        }
                    }
                   
                    return
                }
            }
            print("There was an error in returning the data: \(error?.localizedDescription ?? "Uknown error!")")
            
        }.resume()
    }
    
}

struct ITunesQuery_Previews: PreviewProvider {
    static var previews: some View {
        ITunesQuery()
    }
}
