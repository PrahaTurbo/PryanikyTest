//
//  ItemRow.swift
//  Pryaniky
//
//  Created by Артем Ластович on 26.05.2022.
//

import SwiftUI
import Kingfisher

struct ItemRow: View {
    let item: ServerResponse.Data
    @Binding var selection: ServerResponse.Data.Item.Variant
    @Binding var tappedItem: ServerResponse.Data?
    
    var body: some View {
        VStack {
            switch item.name {
            case .hz, .picture:
                Button {
                    tappedItem = item

                } label: {
                    VStack {
                        if let url = item.data.url {
                            KFImage(url)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                        
                        Text(item.data.text ?? "")
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.1), radius: 10)
                }
                .buttonStyle(ScaledButton())
                
            case .selector:
                if let variants = item.data.variants {
                    Picker("Choose variant", selection: $selection) {
                        ForEach(variants) { variant in
                            Text(variant.text)
                                .tag(variant)
                        }
                    }
                    .onChange(of: selection) { selection in
                        tappedItem = item
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
