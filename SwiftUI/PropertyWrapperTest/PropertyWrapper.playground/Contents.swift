import SwiftUI

struct Rectangle {
    private var _width = 0
    var width: Int {
        get { return _width }
        set { _width = min(newValue, 12) }
    }
    
    private var _height = 0
    var height: Int {
        get { return _height }
        set { _height = min(newValue, 12) }
    }
}

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var width: Int
    @TwelveOrLess var height: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)

rectangle.height = 10
print(rectangle.height)

rectangle.height = 24
print(rectangle.height)

rectangle.width = 15
print(rectangle.width)
