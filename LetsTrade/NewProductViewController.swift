//
//  NewProductViewController.swift
//  LetsTrade
//
//  Created by Gary Naz on 11/21/20.
//

import Foundation
import UIKit

class NewProductViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var barButton =  UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    
    let additionalInfo : UITextView = {
        let description = UITextView()
        description.text = "Description"
        description.textColor = .lightGray
        description.textAlignment = .left
        description.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        description.backgroundColor = .white
        description.addDoneCancelToolbar()
        return description
    }()
    
    let titleField : UITextField = {
        let titleField = UITextField()
        titleField.placeholder = "Title"
        titleField.textAlignment = .center
        titleField.backgroundColor = .white
        titleField.addDoneCancelToolbar()
        return titleField
    }()
    
    let priceField : UITextField = {
        let priceField = UITextField()
        priceField.placeholder = "Price"
        priceField.textAlignment = .center
        priceField.backgroundColor = .white
        priceField.keyboardType = .numberPad
        priceField.addDoneCancelToolbar()
        return priceField
    }()
    
    let newImageView : UIImageView = {
        let newImageView = UIImageView()
        newImageView.image = UIImage(systemName: "camera.circle")
        newImageView.contentMode = .scaleAspectFit
        newImageView.layer.cornerRadius = 10
        return newImageView
    }()
    
    let addImgButton : UIButton = {
        let addImgButton = UIButton()
        addImgButton.setTitle("Add Image", for: .normal)
        addImgButton.setTitleColor(UIColor.systemGray, for: .normal)
        addImgButton.layer.cornerRadius = 10
        addImgButton.backgroundColor = .white
        addImgButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        return addImgButton
    }()
    
    let postButton : UIButton = {
        let postButton = UIButton()
        postButton.setTitleColor(UIColor.white, for: .normal)
        postButton.backgroundColor = .systemIndigo
        postButton.setTitle("Post Ad", for: .normal)
        postButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        postButton.layer.cornerRadius = 10
        return postButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceField.delegate = self
        titleField.delegate = self
        additionalInfo.delegate = self
        
        view.backgroundColor = .systemGray5
        viewConfig()
        LayoutConfig()
        setPaddingView(strImgname: "exclamationmark.circle", txtField: titleField)
        setPaddingView(strImgname: "exclamationmark.circle", txtField: priceField)
    }
    
    
    func viewConfig(){
        navigationItem.leftBarButtonItem = barButton
        [postButton, titleField, priceField, newImageView, addImgButton, additionalInfo].forEach{view.addSubview($0)}
    }
    
    
    
    func LayoutConfig(){
                
        titleField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 660, right: 0))
        
        priceField.anchor(top: titleField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 550, right: 0))
        
        additionalInfo.anchor(top: priceField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: newImageView.safeAreaLayoutGuide.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 50, left: 0, bottom: 40, right: 0))
        
        newImageView.anchor(top: priceField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 200, left: 100, bottom: 220, right: 100))
        
        addImgButton.anchor(top: newImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 120, bottom: 140, right: 120))
        
        postButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 660, left: 40, bottom: 40, right: 40))
    }
    
    func setPaddingView(strImgname: String, txtField: UITextField){
        let imageView = UIImageView(image: UIImage(systemName: strImgname)?.withTintColor(.systemRed, renderingMode: .alwaysOriginal))
        imageView.frame = CGRect(x: 0, y: 5, width: imageView.image!.size.width , height: imageView.image!.size.height)
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        paddingView.addSubview(imageView)
        txtField.rightViewMode = .always
        txtField.rightView = paddingView
        txtField.rightView?.isHidden = true
        txtField.setLeftPaddingPoints(50)
    }

    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func newPost(){
        guard
            let title = titleField.text, !title.isEmpty,
            let price = priceField.text, !price.isEmpty
        else
        {
            titleField.rightView?.isHidden = false
            priceField.rightView?.isHidden = false
            return
        }
        
        let newProduct = Product(context: context)
        newProduct.title = title
        newProduct.price = Int64(price)!
        newProduct.photo = (newImageView.image)!.pngData()
        
        do {
            try self.context.save()
        } catch {
            print("Error saving new Product: \(error)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func addImage(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
   }


extension NewProductViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            newImageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


extension NewProductViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        if textField == titleField {
            let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890. "
            let allowedCharSet = CharacterSet(charactersIn: allowedChars)
            let typedCharsSet = CharacterSet(charactersIn: string)
            if allowedCharSet.isSuperset(of: typedCharsSet) && newLength <= 20 {
                return true
            }
        } else {
            let allowedChars = "1234567890. "
            let allowedCharSet = CharacterSet(charactersIn: allowedChars)
            let typedCharsSet = CharacterSet(charactersIn: string)
            if allowedCharSet.isSuperset(of: typedCharsSet) && newLength <= 7 {
                return true
            }
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleField.rightView?.isHidden = true
        priceField.rightView?.isHidden = true
    }

}

extension NewProductViewController : UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
}

