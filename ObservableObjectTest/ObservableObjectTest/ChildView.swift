//
//  OOView.swift
//  ObservableObjectTest
//
//  Created by 윤동주 on 6/3/24.
//

import SwiftUI

struct ChildView: View {
    @StateObject var SOCounter = Counter()
    init() {
        print("나는 ChildView인데 init 실행됨🥹")
    }

    var body: some View {
        VStack {
            Text("\(SOCounter.count)")
            Button("SOCounter 증가") {
                SOCounter.addCount()
                printAddress(of: SOCounter, name: "SOCounter")
            }
        }
    }
}
