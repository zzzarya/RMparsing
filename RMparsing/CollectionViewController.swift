//
//  CollectionViewController.swift
//  RMparsing
//
//  Created by Антон Заричный on 19.09.2022.
//

import UIKit

enum RickInfo: String {
    case firstPage = "https://rickandmortyapi.com/api/character?name=rick"
    case secondPage = "https://rickandmortyapi.com/api/character?page=2&name=rick"
    case thirdPage = "https://rickandmortyapi.com/api/character?page=3&name=rick"
    case fourthPage = "https://rickandmortyapi.com/api/character?page=4&name=rick"
    case fifthPage = "https://rickandmortyapi.com/api/character?page=5&name=rick"
    case sixthPage = "https://rickandmortyapi.com/api/character?page=6&name=rick"
}

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
 //   private var arrayInfo: [Results] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchInfo()
    }
    // MARK: UICollectionViewDataSource
    
    private func fetchInfo() {
        guard let url = URL(string: RickInfo.firstPage.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let rickInfo = try jsonDecoder.decode([Results].self, from: data)
                print(rickInfo)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        15
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! cardCell
    
        cell.layer.cornerRadius = 15
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
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
