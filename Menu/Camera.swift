//
//  Camera.swift
//  Menu
//
//  Created by NCAdevice1 on 13/08/2026.
//

import SwiftUI
import UIKit

struct Camera: View {
    
    @State private var images: [UIImage] = [
        UIImage(named: "pic1")!,
        UIImage(named: "pic2")!,
        UIImage(named: "pic3")!,
        UIImage(named: "pic4")!,
        UIImage(named: "pic5")!,
        UIImage(named: "pic6")!
    ]
    @State private var showCamera = false
    @State private var showPhotoPicker = false
    @State private var selectedImageIndex: Int?
    
    var body: some View {
        
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Restaurant Photos")
                    .font(.title2)
                    .fontWeight(.bold)
                
                if images.isEmpty {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(height: 300)
                        .overlay {
                            VStack(spacing: 10) {
                                Image(systemName: "photo.on.rectangle")
                                    .font(.system(size: 45))
                                    .foregroundStyle(.gray)
                                
                                Text("No photos yet")
                                    .foregroundStyle(.gray)
                            }
                        }
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ],
                            spacing: 12
                        ) {
                            ForEach(images.indices, id: \.self) { index in
                                Button {
                                    selectedImageIndex = index
                                } label: {
                                    Image(uiImage: images[index])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 150)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 15)
                                        )
                                }
                            }
                        }
                    }
                }
                
                VStack(spacing: 12) {
                    
                    Button {
                        showCamera = true
                    } label: {
                        Label("Take Photo", systemImage: "camera")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        showPhotoPicker = true
                    } label: {
                        Label("Choose Photo", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: $images)
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(images: $images)
        }
        .sheet(
            isPresented: Binding(
                get: { selectedImageIndex != nil },
                set: {
                    if !$0 {
                        selectedImageIndex = nil
                    }
                }
            )
        ) {
            if let selectedImageIndex = selectedImageIndex {
                FullScreenImage(
                    images: images,
                    selectedIndex: selectedImageIndex
                )
            }
        }
    }
}

struct FullScreenImage: View {
    
    let images: [UIImage]
    let selectedIndex: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            TabView(selection: .constant(selectedIndex)) {
                
                ForEach(images.indices, id: \.self) { index in
                    ZoomableImage(image: images[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            .background(.black)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

struct ZoomableImage: View {
    
    let image: UIImage
    
    @State private var scale: CGFloat = 1
    @State private var offset: CGSize = .zero
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)
            .offset(offset)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = max(1, value)
                        
                        if scale == 1 {
                            offset = .zero
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            if scale < 1.05 {
                                scale = 1
                                offset = .zero
                            }
                        }
                    }
            )
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        if scale > 1 {
                            offset = value.translation
                        }
                    }
                    .onEnded { _ in
                        if scale <= 1 {
                            offset = .zero
                        }
                    }
            )
            .onTapGesture(count: 2) {
                withAnimation {
                    if scale == 1 {
                        scale = 2
                    } else {
                        scale = 1
                        offset = .zero
                    }
                }
            }
    }
}

struct CameraPicker: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
        
        let parent: CameraPicker
        
        init(_ parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info:
                [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.editedImage] as? UIImage {
                parent.images.append(image)
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController
        ) {
            picker.dismiss(animated: true)
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
        
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info:
                [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.editedImage] as? UIImage {
                parent.images.append(image)
            } else if let image = info[.originalImage] as? UIImage {
                parent.images.append(image)
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController
        ) {
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    Camera()
}
