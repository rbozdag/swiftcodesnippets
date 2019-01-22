import Foundation

public extension Array {
    public func flatten() -> [Element] {
        return Array.flatten(0, self)
    }
    
    public static func flatten<Element>(_ index: Int, _ toFlat: [Element]) -> [Element] {
        guard index < toFlat.count else { return [] }
        
        var flatten: [Element] = []
        
        if let itemArr = toFlat[index] as? [Element] {
            flatten = flatten + itemArr.flatten()
        } else {
            flatten.append(toFlat[index])
        }
        
        return flatten + Array.flatten(index + 1, toFlat)
    }
}

