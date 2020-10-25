//
//  PopupViewController.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/25.
//  Copyright © 2020 한승희. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDescription: UILabel!
    @IBOutlet weak var garbageTypeCollectionView: UICollectionView!
    @IBOutlet weak var selectedTypeLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    
    private static let TAG_CAMERA_BUTTON = 1001
    private static let TAG_PHOTO_LIBRARY_BUTTON = 1002
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        garbageTypeCollectionView.delegate = self
        garbageTypeCollectionView.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK:- Event Function
    @IBAction func clickedCameraButton(_ sender: UIButton) {
        
        switch sender.tag {
        
        case PopupViewController.TAG_CAMERA_BUTTON:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                present(imagePickerController, animated: true, completion: nil)
            } else {
                print("카메라 권한이요")
            }
            
        case PopupViewController.TAG_PHOTO_LIBRARY_BUTTON:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePickerController.sourceType = .photoLibrary
                present(imagePickerController, animated: true, completion: nil)
            } else {
                print("앨범 권한이요")
            }
        default:
            print(" invalid tag number: \(sender.tag)")
        }
    }
    
    @IBAction func clickedCountPlusButton(_ sender: Any) {
        let count:Int = Int(countTextField.text ?? "") ?? 0
        self.countTextField.text = String(count+1)
    }
    
    @IBAction func clickedEnrollButton(_ sender: Any) {
        
        // 여기서 등록버튼을 누르면 HomeViewController 의 값이 동시에 바뀌도록 설정해줘야함! (이게아마 Noti)
    }
}

extension PopupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let loadedImage = info[.originalImage] as? UIImage {
            self.imageView.image = loadedImage
            imageDescription.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
}


extension PopupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GarbageType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GarbageTypeCell", for: indexPath) as! GarbageTypeCollectionViewCell
        cell.nameLabel.text = GarbageType.init(rawValue: indexPath.row)?.name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("touch >> \(indexPath.row)")
        
        let cell = collectionView.cellForItem(at: indexPath) as? GarbageTypeCollectionViewCell
        selectedTypeLabel.text = cell?.nameLabel.text
        countTextField.text = "1"
    }
    
}
