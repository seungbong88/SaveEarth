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
        countTextField.text = String(count+1)
    }
    
    @IBAction func clickedEnrollButton(_ sender: Any) {
        if selectedCellIndex != -1 {
            if let type = WasteType.init(rawValue: selectedCellIndex),
               let count = Int(countTextField.text ?? ""),
               let image = imageView.image {
                let wasteInfo = WasteInfo(savedImage: image, wasteType: type, wasteCount: count)
                // 노티노티!
                NotificationCenter.default.post(name: Notification.Name("Noti_EditWasteTime"), object: wasteInfo)
                print("wasteInfo.totalRotTime: \(wasteInfo.totalRotTime)")
            }
        }
        
        dismiss(animated: true, completion: nil)
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
        return WasteType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WasteTypeCell", for: indexPath) as! WasteTypeCollectionViewCell
        cell.nameLabel.text = WasteType.init(rawValue: indexPath.row)?.name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("touch >> \(indexPath.row)")
        
        selectedCellIndex = indexPath.row
        let cell = collectionView.cellForItem(at: indexPath) as? WasteTypeCollectionViewCell
        selectedTypeLabel.text = cell?.nameLabel.text
        countTextField.text = "1"
    }
    
}
