//
//  GameDetailApi.swift
//  Game Store
//
//  Created by Adji Firmansyah on 16/08/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import Foundation
import SwiftUI

class GameDetailApi: ObservableObject {
    @Published var gameDetail: Game?
    func loadData(gameId: Int) {
        
        guard let detailUrl = URL(string: "https://api.rawg.io/api/games/\(gameId)") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: detailUrl)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Game.self, from: data) {
                    // menerima dan menampilkan data secara async 
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.gameDetail = decodedResponse
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
