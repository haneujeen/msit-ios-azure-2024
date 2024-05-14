import SwiftUI

@propertyWrapper
struct TwelveOrLess {
    private var number: Int
    private(set) var projectedValue: String
    var wrappedValue: Int {
        get { return number }
        set {
            number = min(newValue, 12)
            projectedValue = "\(number)"
        }
    }
    
    init(wrappedValue initialValue: Int) {
        self.number = initialValue
        self.projectedValue = ""
    }
}

struct SmallRectangle {
    @TwelveOrLess var width: Int
    @TwelveOrLess var height: Int
}

var rectangle = SmallRectangle(width: 20, height: 15)
print(rectangle.width, rectangle.height)

rectangle.width = 15
rectangle.height = 24
print(rectangle.width, rectangle.height)
print(rectangle.$width, rectangle.$height)
