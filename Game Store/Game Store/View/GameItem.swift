//
//  PosterRow.swift
//  Game Store
//
//  Created by Adji Firmansyah on 31/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct GameItem: View {
    @State var results = [GAME] ()
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            Text("Popular")
                .font(.largeTitle)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
               
            ScrollView {
                if (results.count==0) {
                HStack {
                    Spacer()
                }
                }
                ForEach (results, id: \.id) {VItem in
                    NavigationLink(destination: DetailGame(results: VItem)) {
                    VStack {
                    ZStack (alignment: .leading){
                        Color.white
                            .frame(height: 110)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                        
                        HStack {
                            VViewContainer(imageUrl: VItem.backgroundImage)
                             /*   .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90,height: 120)
                                .clipped()
                                .cornerRadius(16)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 2))
                                .frame(height: 150, alignment: .top) */
                            VStack (alignment: .leading) {
                                Text(VItem.name)
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.black)
                                    .minimumScaleFactor(0.05)
                                    
                                Text("Release : \(VItem.released)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("Rating ")
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }.frame(height: 90)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    Spacer(minLength: 0)
                }
                    }
            }
            }
        }.onAppear(perform: loadData)
    }
    func loadData() {
        guard let url = URL(string: "https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-added") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // menerima dan menampilkan data
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.results = decodedResponse.results
                    }
                    //
                    return
                }
            }
            // Error
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct GameItem_Previews: PreviewProvider {
    static var previews: some View {
        GameItem()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
