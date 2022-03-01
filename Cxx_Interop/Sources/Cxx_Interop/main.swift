
import Foundation
import Cxx

public struct Cxx_Interop {
    public static func main() {
        let result = cxxFunction(7)
        print(result)
    }
}

Cxx_Interop.main()
