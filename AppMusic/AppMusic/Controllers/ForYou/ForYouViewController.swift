//
//  ForYouViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 12/07/2022.
//

import UIKit

class ForYouViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var inforTableView: UITableView!
    @IBOutlet weak var imageButton: UIButton!
    
    //MARK: - Variables
    var categoryList: [CategoryModel] = [CategoryModel(icon: "user", title: "Cập nhật thông tin"),
                                         CategoryModel(icon: "music-folder", title: "Lịch sử bài hát"),
                                         CategoryModel(icon: "musical-1", title: "Bài hát yêu thích"),
                                         CategoryModel(icon: "download", title: "Download"),
                                         CategoryModel(icon: "setting", title: "Đặt lại mật khẩu")]
    
    var pickerController: UIImagePickerController!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Account"
        userNameLabel.text = "123456789"
        
        userImageView.layer.cornerRadius = userImageView.frame.width/3
        imageButton.layer.cornerRadius = userImageView.frame.width/3
        
        inforTableView.dataSource = self
        inforTableView.delegate = self
        inforTableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
    }
    
    //MARK: - Actions
    @IBAction func touchChangeImageUserButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Take image", message: "Choose Image source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            print("You choose camera")
            self.openCamera()
        }
        let photoAction = UIAlertAction(title: "Your photos", style: .default) { (action) in
            print("You choose photo")
            self.openPhotos()
        }
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        self.present(actionSheet, animated: true)
    }
    
    func openCamera() {
        pickerController = UIImagePickerController()
        if (UIImagePickerController.isSourceTypeAvailable(.camera) == false) {
            return
        }
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .camera
        
        self.present(pickerController, animated: true) {
            print("presented camera")
        }
    }
    
    func openPhotos() {
        pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        
        self.present(pickerController, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension ForYouViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
        cell.titleLabel.text = categoryList[indexPath.row].title
        cell.imgView.image = UIImage(named: categoryList[indexPath.row].icon)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ForYouViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightCell = inforTableView.frame.height/CGFloat(categoryList.count)
        return heightCell
    }
}

extension ForYouViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        pickerController.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.userImageView.image = image
    }
}
