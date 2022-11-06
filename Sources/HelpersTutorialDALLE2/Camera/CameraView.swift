//
//  CameraView.swift
//  OpenAI
//
//  Created by Home on 4/11/22.
//

import Foundation
import UIKit
import SwiftUI

public struct CameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?
    @Environment(\.dismiss) var dismiss
    
    public init(selectedImage: Binding<Image?>) {
        self._selectedImage = selectedImage
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        imagePickerController.showsCameraControls = true
        return imagePickerController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Empty
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(cameraView: self)
    }
}

final public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    var cameraView: CameraView
 
    init(cameraView: CameraView) {
        self.cameraView = cameraView
    }
 
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            cameraView.selectedImage = Image(uiImage: image)
        }
        cameraView.dismiss()
    }
}
