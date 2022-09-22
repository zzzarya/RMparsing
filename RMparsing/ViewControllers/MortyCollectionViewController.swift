//
//  MortyCollectionViewController.swift
//  RMparsing
//
//  Created by Антон Заричный on 22.09.2022.
//

import UIKit

class MortyCollectionViewController: UICollectionViewController {

    private var arrayInfo: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    private func fetchInfo() {
        for index in 0..<MortyInfo.allCases.count {
            NetworkManager.shared.fetchInfo(url: MortyInfo.allCases[index].rawValue) { array in
                self.arrayInfo += array
            }
        }
    }
    
    // MARK: - UICollectionViewv
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayInfo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MortyCell", for: indexPath) as! MortyCell
        
        NetworkManager.shared.fetchImages(urlImage: arrayInfo[indexPath.item].image ?? "") { imageData in
            cell.mortyImage.image = UIImage(data: imageData)
        }
        
        cell.mortyNameLabel.text = arrayInfo[indexPath.item].name
        
        cell.layer.cornerRadius = 15
        
        return cell
    }
}
 
    // MARK: - UICollectionViewDelegateFlowLayout
extension MortyCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow : CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availabelWidth = collectionView.frame.width - paddingWidth
        let withPerItem = availabelWidth / itemsPerRow
        return CGSize(width: withPerItem, height: withPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
}

