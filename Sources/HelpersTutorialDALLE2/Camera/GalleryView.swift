import Foundation
import UIKit
import SwiftUI

public struct GalleryView: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?
    @Environment(\.dismiss) var dismiss
    
    public init(selectedImage: Binding<Image?>) {
        self._selectedImage = selectedImage
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        return imagePickerController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Empty
    }
    
    public func makeCoordinator() -> GalleryCoordinator {
        GalleryCoordinator(galleryView: self)
    }
}

final public class GalleryCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    var galleryView: GalleryView
 
    init(galleryView: GalleryView) {
        self.galleryView = galleryView
    }
 
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            galleryView.selectedImage = Image(uiImage: image)
        }
        galleryView.dismiss()
    }
}
