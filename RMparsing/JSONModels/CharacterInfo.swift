//
//  RickInfo.swift
//  RMparsing
//
//  Created by Антон Заричный on 19.09.2022.
//

import Foundation

struct Character: Decodable {
    let name: String?
    let image: String?
}

struct Results: Decodable {
    let results: [Character]
}
