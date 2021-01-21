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
    @IBOutlet weak var wasteTypeCollectionView: UICollectionView!
    @IBOutlet weak var selectedTypeLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    
    private static let TAG_CAMERA_BUTTON = 1001
    private static let TAG_PHOTO_LIBRARY_BUTTON = 1002
    
    private let imagePickerController = UIImagePickerController()
    private var selectedCellIndex: Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        wasteTypeCollectionView.delegate = self
        wasteTypeCollectionView.dataSource = self
        
        self.modalPresentationStyle = .fullScreen
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키패드가 올라와 있으면 닫아준다.
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
        countTextField.text = String(count+1)
    }
    
    @IBAction func clickedEnrollButton(_ sender: Any) {
        if selectedCellIndex != -1 {
            guard let type = Common.WasteType(rawValue: selectedCellIndex) else {
                return
            }
            let image = imageView.image ?? UIImage(named: "default")!
            let enrolledInfo = EnrolledWasteInfo(image: image, date: Date())
            let count = Int(countTextField.text ?? "") ?? 0
            enrolledInfo.addWastePair(type: type, count: count)
            
            SessionManager.userData?.enroll(enrolledWaste: enrolledInfo)
        }
        
        dismiss(animated: true, completion: nil)
    }
}


// MARK:- Collection View Delegate
extension PopupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Common.WasteType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WasteTypeCell", for: indexPath) as! WasteTypeCollectionViewCell
        cell.nameLabel.text = Common.WasteType(rawValue: indexPath.row)?.name ?? ""

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.row
        let cell = collectionView.cellForItem(at: indexPath) as? WasteTypeCollectionViewCell
        selectedTypeLabel.text = cell?.nameLabel.text
        countTextField.text = "1"
    }
    
}


// MARK:- ImagePicker Delegate
extension PopupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let loadedImage = info[.originalImage] as? UIImage {
            self.imageView.image = loadedImage
            imageDescription.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
}
