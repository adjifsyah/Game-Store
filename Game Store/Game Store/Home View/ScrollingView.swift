//
//  PosterRow.swift
//  Game Store
//
//  Created by Adji Firmansyah on 31/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct ScrollingView: View {
    @State var scrolling = [Game]()
    @State var slider = [Game]()
    @State var isFavorite = false
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    // update data
                    if slider.isEmpty {
                        HStack (alignment: .center) {
                            ImageShimmer()
                            .padding(16)
                        }
                    } else {
                        ForEach (slider, id: \.id) {item in
                            NavigationLink(destination: DetailGame(gameId: Int(item.id!), DataGames: GameModel())) {
                                ImageViewContainer(imageUrl: item.backgroundImage ?? "")
                                    .frame(width: 350,height: 180)
                                    .cornerRadius(20)
                                    .padding(.leading, 16)
                            }
                        }
                    }
                }
            }.onAppear(perform: loadData)
            Text("Popular")
                .font(.system(size: 24))
                .bold()
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            ScrollView {
                if (scrolling.count==0) {
                    HStack {
                        Text("Loading...")
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16 ))
                    }
                }
                ForEach (scrolling, id: \.id) {scroll in
                    VStack {
                    
                    NavigationLink(destination: DetailGame(gameId: Int(scroll.id!), DataGames: GameModel())) {
                        VStack {
                            ZStack (alignment: .leading) {
                                Color.white
                                    .frame(height: 110)
                                    .cornerRadius(20)
                                    .shadow(radius: 4)
                                HStack {
                                    if scroll.backgroundImage!.isEmpty {
                                         ScrollShimmer()
                                    } else {
                                    ImageViewContainer(imageUrl: scroll.backgroundImage ?? "")
                                        .scaledToFill()
                                        .frame(width: 90,height: 120)
                                        .clipped()
                                        .cornerRadius(16)
                                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 2))
                                        .frame(height: 150, alignment: .top)
                                    }
                                    VStack (alignment: .leading) {
                                        Text("\(scroll.name ?? "")")
                                            .font(.body)
                                            .bold()
                                            .foregroundColor(.black)
                                            .minimumScaleFactor(0.05)
                                        Text("\(scroll.released ?? "")")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        ZStack {
                                            Color.black
                                                .opacity(0.4)
                                                .frame(width: 75, height: 30)
                                                .cornerRadius(15)
                                            HStack (alignment: .center) {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.yellow)
                                                Text("\(scroll.rating!, specifier: "%.2f")")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.white)
                                                    .bold()
                                            }
                                        }
                                    }.frame(height: 90)
                                }
                            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            Spacer(minLength: 0)
                        }
                    }
                }
                }
            }
        }.onAppear(perform: loadVData)
            .navigationBarTitle(" ", displayMode: .inline)
            .navigationBarHidden(true)
    }
    func loadData() {
        guard let url = URL(string: "https://api.rawg.io/api/games?page_size=4&dates=2019-10-10,2020-10-10&ordering=-added") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.slider = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadVData() {
        guard let url = URL(string: "https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-added") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // menerima dan menampilkan data
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.scrolling = decodedResponse.results
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
        ScrollingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
