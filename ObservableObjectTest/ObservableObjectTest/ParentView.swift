//
//  ContentView.swift
//  ObservableObjectTest
//
//  Created by 윤동주 on 6/3/24.
//

import SwiftUI

struct ParentView: View {
    @State var isTapped = false
    
    init() {
        print("나는 ParentView인데 init 실행됨🥹")
    }
    
    var body: some View {
        VStack {
            Text("\("isTapped: \(isTapped)")")
            Button("isTapped Toggle") {
                isTapped.toggle()
            }
            ChildView()
        }
    }
}
