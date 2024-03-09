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
            SearchField(query: $viewModel.query)
            
            Text(viewModel.query)
        }
    }
}

struct SearchField: View {
    @Binding var query: String
    
    var body: some View {
        TextField("Search Query", text: $query)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

class SearchViewModel: ObservableObject {
    @Published var query = ""
}

#Preview {
    ContentView()
}
