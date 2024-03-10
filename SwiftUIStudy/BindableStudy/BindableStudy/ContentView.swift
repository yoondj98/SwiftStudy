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
            SearchView(viewModel: viewModel)
            
            Text(viewModel.query)
        }
    }
}

struct SearchView: View {
    @Bindable var viewModel: SearchViewModel
    
    var body: some View {
        // $viewModel을 찾을 수가 없음 -> property Wrapper로 감싸져있지 않아서
        // Binding으로 감싸서 get set 선언하는 대신 쉽게 @Bindable을 사용.
        SearchField(query: $viewModel.query)
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
