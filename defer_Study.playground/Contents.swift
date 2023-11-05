import UIKit


func deferTest() {
    print("first")
    
    defer { print("second-defer") }
    
    print("third")
}
 
deferTest()

/*
first
third
second-defer
*/

func deferTest2() {
    print("first")
    return;
    defer { print("second-defer") }
}

deferTest2()

// first
// defer 이전에 함수가 종료되면 defer는 실행되지 않는다.

func deferTest3() {
    defer { print("first-defer") }
    defer { print("second-defer") }
    defer { print("third-defer") }
}

deferTest3()
/*
 third-defer
 second-defer
 first-defer
 */
// 먼저 들어온 defer가 stack구조로 쌓임. -> 즉, 뒤에 적힌 defer가 먼저 실행된다.


func deferTest4() {
    defer {
        defer {
            defer {
                print("first-defer")
            }
            print("second-defer")
        }
        print("third-defer")
    }
}

deferTest4()
/*
 third-defer
 second-defer
 first-defer
 */
// 중첩된 defer에서는 간단히 생각하면 바깥 defer 먼저 실행된다고 생각하면 된다.
