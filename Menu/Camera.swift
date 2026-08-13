//
//  Camera.swift
//  Menu
//
//  Created by NCAdevice1 on 13/08/2026.
//

import SwiftUI
import UIKit

struct Camera: View {
    
    @State private var image: UIImage?
    @State private var showCamera = false
    
    var body: some View {
        
        VStack {
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            Button("Take Photo") {
                showCamera = true
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(image: $image)
        }
    }
}

    struct CameraPicker: UIViewControllerRepresentable {
        
        @Binding var image: UIImage?
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            
            let parent: CameraPicker
            
            init(_ parent: CameraPicker) {
                self.parent = parent
            }
            
            func imagePickerController(
                _ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
            ) {
                if let image = info[.editedImage] as? UIImage {
                    parent.image = image
                } else if let image = info[.originalImage] as? UIImage {
                    parent.image = image
                }
                
                picker.dismiss(animated: true)
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true)
            }
        }
    }


#Preview {
    Camera()
}
