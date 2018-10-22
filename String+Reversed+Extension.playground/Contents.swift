extension Optional where Wrapped == String {
    func reversed() -> String? {
        guard let str = self else { return nil }
        return String(str.reversed())
    }
}

