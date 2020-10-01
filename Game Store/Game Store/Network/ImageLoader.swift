//
//  File.swift
//  Game Store
//
//  Created by Adji Firmansyah on 27/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var data: Data?
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                print("data")
                self.data = data
            }
        }.resume()
    }
}

struct ImageViewContainer: View {
    @ObservedObject var imageLoader: ImageLoader
    init(imageUrl: String) {
        imageLoader  = ImageLoader(imageUrl: imageUrl)
    }
    var body: some View {
        Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage.init(named: "LoadingImage")!)
            .renderingMode(.original)
            .resizable()
    }
}
struct ImageView: View {
    let image_url = "https://api.rawg.io/api/games"
    var body: some View {
        List{
            ForEach(1..<10) {_ in
                ImageViewContainer(imageUrl: self.image_url)
                
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
