//
//  ImagePicker.swift
//  Game Store
//
//  Created by Adji Firmansyah on 20/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var showImagePicker: Bool
    @Binding var image: Data
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        
        return ImagePicker.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewContoller: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child: ImagePicker
        
        init(child1: ImagePicker) {
            child = child1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.showImagePicker.toggle()
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.child.image = data!
            self.child.showImagePicker.toggle()
        }
    }
}
