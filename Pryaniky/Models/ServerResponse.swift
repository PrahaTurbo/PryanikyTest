//
//  ServerResponse.swift
//  Pryaniky
//
//  Created by Артем Ластович on 26.05.2022.
//

import Foundation

struct ServerResponse: Codable {
    let data: [Data]
    let view: [ItemType]
    
    struct Data: Codable {
        let name: ItemType
        let data: Item
        
        struct Item: Codable {
            let text: String?
            let url: URL?
            let selectedId: Int?
            let variants: [Variant]?
            
            struct Variant: Codable, Hashable, Identifiable {
                let id: Int
                let text: String
            }
        }
    }
    
    static let example = ServerResponse(data: [Data(name: .picture, data: Data.Item(text: "some text", url: nil, selectedId: nil, variants: nil))], view: [.selector])
}

enum ItemType: String, Codable{
    case hz = "hz"
    case picture = "picture"
    case selector = "selector"
}




