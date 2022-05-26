//
//  ContentView.swift
//  Pryaniky
//
//  Created by Артем Ластович on 26.05.2022.
//

import SwiftUI

struct Main: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Last tapped item:")
                                .bold()
                            
                            Text(viewModel.tappedItem?.name.rawValue ?? " ")
                        }
                        
                        HStack {
                            Text("More info:")
                                .bold()
                            
                            if let text = viewModel.tappedItem?.data.text {
                                Text("text — \(text)")
                            }
                            
                            if let variant = viewModel.tappedItem?.data.variants {
                              let selection = variant.first { $0 == viewModel.selection}
                                Text("id — \(selection?.id ?? 0),")
                                
                                Text("selection — \(selection?.text ?? "")")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(viewModel.order, id: \.self) { type in
                        if let item = viewModel.data.first { $0.name == type } {
                            ItemRow(item: item, selection: $viewModel.selection, tappedItem: $viewModel.tappedItem)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .task {
                await viewModel.getData()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
