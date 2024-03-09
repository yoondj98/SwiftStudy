//
//  ContentView.swift
//  BindableStudy
//
//  Created by 윤동주 on 3/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            TextField("Search Query", text: $viewModel.query)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text(viewModel.query)
        }
    }
}

class SearchViewModel: ObservableObject {
    @Published var query = ""
}

#Preview {
    ContentView()
}
