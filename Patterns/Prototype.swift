import Foundation

protocol Cloneable {
    func clone() -> Self?
}

extension Cloneable where Self: Codable {
    func clone() -> Self? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let clone = try? decoder.decode(Self.self, from: data) else {
            return nil
        }
        
        return clone
    }
}


// Sample

class Customer: Codable, Cloneable {
    let id: String
    let name: String
    let surname: String
    
    init(id: String, name: String, surname: String) {
        self.id = id
        self.name = name
        self.surname = surname
    }
}

extension Customer: Equatable {
    static func == (lhs: Customer, rhs: Customer) -> Bool {
        return lhs.id == rhs.id
    }
}

let customer = Customer(id: "1", name: "Rahmi", surname: "Bozdag")
if let clone = customer.clone() {
    print("customer: \(customer.id) \(customer.name) \(customer.surname)")
    print("clone: \(clone.id) \(clone.name) \(clone.surname)")
    
    if clone == customer {
        print("customer and its own clone is equal each other")
    }
    
    if clone !== customer {
        print("customer and its own clone has different memory address")
    }
}

