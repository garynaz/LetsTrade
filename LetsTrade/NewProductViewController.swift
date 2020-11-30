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
    
    var imageView = UIImageView()
    let image = UIImage(systemName: "exclamationmark.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    

    
    let postButton : UIButton = {
        let postButton = UIButton()
        postButton.setTitleColor(UIColor.white, for: .normal)
        postButton.backgroundColor = .systemIndigo
        postButton.setTitle("Post Ad", for: .normal)
        postButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        postButton.layer.cornerRadius = 10
        return postButton
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceField.delegate = self
        titleField.delegate = self
        
        view.backgroundColor = .systemGray5
        viewConfig()
        LayoutConfig()
        setPaddingView(strImgname: "exclamationmark.circle", txtField: titleField)
        setPaddingView(strImgname: "exclamationmark.circle", txtField: priceField)
    }
    
    
    func viewConfig(){
        navigationItem.leftBarButtonItem = barButton
        [postButton, titleField, priceField, newImageView, addImgButton].forEach{view.addSubview($0)}
    }
    
    
    
    func LayoutConfig(){

        titleField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 660, right: 0))
        
        priceField.anchor(top: titleField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 550, right: 0))
        
        newImageView.anchor(top: priceField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 40, bottom: 250, right: 40))
        
        addImgButton.anchor(top: newImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 120, bottom: 180, right: 120))
        
        postButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 660, left: 40, bottom: 40, right: 40))
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
    
    func setPaddingView(strImgname: String,txtField: UITextField){
            let imageView = UIImageView(image: UIImage(systemName: strImgname)?.withTintColor(.systemRed, renderingMode: .alwaysOriginal))
            imageView.frame = CGRect(x: 0, y: 5, width: imageView.image!.size.width , height: imageView.image!.size.height)
            let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
            paddingView.addSubview(imageView)
            txtField.rightViewMode = .always
            txtField.rightView = paddingView
            txtField.rightView?.isHidden = true
        
        txtField.setLeftPaddingPoints(50)
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
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
