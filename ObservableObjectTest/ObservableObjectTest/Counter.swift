//
//  Counter.swift
//  ObservableObjectTest
//
//  Created by 윤동주 on 6/3/24.
//

import Foundation

final class Counter: ObservableObject {
    @Published var count: Int = 0
    
    func addCount() {
        self.count += 1
    }
}


func printAddress(of object: AnyObject, name: String) {
    let address = Unmanaged.passUnretained(object).toOpaque()
    print("Memory address: \(address)-\(name)")
}
