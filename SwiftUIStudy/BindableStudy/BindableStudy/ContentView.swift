//
//  ContentView.swift
//  BindableStudy
//
//  Created by 윤동주 on 3/9/24.
//

import SwiftUI

struct ContentView: View {
    // StateObject 대신 State를 사용
    @State var viewModel = SearchViewModel()
    
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

// @Observable 매크로를 달아줌으로서 @Published를 달아주지 않아도 됨.
@Observable
class SearchViewModel {
    var query = ""
}

#Preview {
    ContentView()
}
