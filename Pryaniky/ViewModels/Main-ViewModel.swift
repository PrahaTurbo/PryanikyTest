//
//  Main-ViewModel.swift
//  Pryaniky
//
//  Created by Артем Ластович on 26.05.2022.
//

import Foundation

extension Main {
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var data = [ServerResponse.Data]()
        @Published var order = [ItemType]()
        @Published var selection = ServerResponse.Data.Item.Variant(id: 1, text: "") 
        @Published var tappedItem: ServerResponse.Data?
        
        let url = "https://pryaniky.com/static/json/sample.json"
        
        func getData() async {
            do {
                let result: ServerResponse = try await APIService.shared.fetchData(url: url)
                data = result.data
                order = result.view
                
                let selector = result.data.first { $0.name == .selector }
                let selectorId = selector?.data.selectedId
                
                selection = selector?.data.variants?.first { $0.id == selectorId } ?? ServerResponse.Data.Item.Variant(id: 1, text: "")
            } catch {
                print("Handle error: \(error)")
            }
        }
    }
}
