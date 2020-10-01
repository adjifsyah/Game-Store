//
//  SearchView.swift
//  Game Store
//
//  Created by Adji Firmansyah on 02/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @Binding var back : Bool
    @State var ShowSearch = false
    @State var isFavorite = false
    @State var txt = ""
    @State var results = [Game] ()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search...", text: self.$txt,
                              onCommit: { self.loadData() })
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                Button(action: {
                                    self.ShowSearch.toggle()
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                        })
                    Button(action: {
                        withAnimation {
                            self.txt = ""
                            self.back.toggle()
                        }
                    }) {
                        Text("Batal").foregroundColor(.black)
                    }
                }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                VStack {
                    List (self.results, id: \.id) {search in
                        NavigationLink(destination: DetailGame(gameId: Int(search.id!), DataGames: GameModel())) {
                            HStack (alignment: .top) {
                                ImageViewContainer(imageUrl: search.backgroundImage ?? "")
                                    .scaledToFill()
                                    .frame(width: 80,height: 100)
                                    .clipped()
                                    .cornerRadius(15)
                                VStack (alignment: .leading) {
                                    Text("\(search.name ?? "")")
                                        .font(.system(size: 16))
                                        .bold()
                                        .lineLimit(1)
                                    Text("\(search.released ?? "")")
                                        .font(.system(size: 12))
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
                                            Text("\(search.rating ?? 0, specifier: "%.2f")")
                                                .font(.system(size: 11))
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                    }
                                }.padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                            }
                        }
                    }.onAppear(perform: self.loadData)
                }
            }.navigationBarTitle(" ")
                .navigationBarHidden(true)
        }
    }
    func loadData() {
        guard var url = URLComponents(string: "https://api.rawg.io/api/games") else {
            print("Invalid URL")
            return
        }
        url.queryItems = [
            URLQueryItem(name: "search", value: "\(txt)"),
            URLQueryItem(name: "page_size", value: "10")
        ]
        let request = URLRequest(url: url.url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    //
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var back = false
    static var previews: some View {
        SearchView(back: $back)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
