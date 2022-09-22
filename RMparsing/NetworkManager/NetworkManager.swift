//
//  NetworkManager.swift
//  RMparsing
//
//  Created by Антон Заричный on 22.09.2022.
//

import Foundation

enum RickInfo: String, CaseIterable {
    case firstPage = "https://rickandmortyapi.com/api/character?name=rick"
    case secondPage = "https://rickandmortyapi.com/api/character?page=2&name=rick"
    case thirdPage = "https://rickandmortyapi.com/api/character?page=3&name=rick"
    case fourthPage = "https://rickandmortyapi.com/api/character?page=4&name=rick"
    case fifthPage = "https://rickandmortyapi.com/api/character?page=5&name=rick"
    case sixthPage = "https://rickandmortyapi.com/api/character?page=6&name=rick"
}

enum MortyInfo: String, CaseIterable {
    case firstPage = "https://rickandmortyapi.com/api/character?name=morty"
    case secondPage = "https://rickandmortyapi.com/api/character?page=2&name=morty"
    case thirdPage = "https://rickandmortyapi.com/api/character?page=3&name=morty"
    case fourthPage = "https://rickandmortyapi.com/api/character?page=4&name=morty"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchInfo(url: String, completion: @escaping([Character]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let rickInfo = try jsonDecoder.decode(Results.self, from: data)
                let array = rickInfo.results
                completion(array)
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImages(urlImage: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: urlImage) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
