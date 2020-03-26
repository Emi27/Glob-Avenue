//
//  ImagePicker.swift
//  Glob Avenue
//
//  Created by Imran Malik on 28/02/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
    func didSelect(video: URL?)
}

public enum mediaType {
    case image
    case video
}

open class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
//        self.pickerController.allowsEditing = true
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView, mediaType: mediaType) {
        var cameraTitle = ""
        if mediaType == .image {
            self.pickerController.mediaTypes = ["public.image"]
            cameraTitle = "Take photo"
        } else {
            self.pickerController.mediaTypes = ["public.movie"]
            cameraTitle = "Capture video"
        }

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: cameraTitle) {
            alertController.addAction(action)
        }
//        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
//            alertController.addAction(action)
//        }
        if let action = self.action(for: .photoLibrary, title: "Phone library") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image)
    }
    
    private func pickerController(controller: UIImagePickerController, didSelect video: URL?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(video: video)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            self.delegate?.didSelect(video: url)
        } else {
            guard let image = info[.originalImage] as? UIImage else {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            self.delegate?.didSelect(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ImagePicker: UINavigationControllerDelegate {

}
