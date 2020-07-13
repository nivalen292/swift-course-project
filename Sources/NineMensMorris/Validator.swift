struct Validator {
  static func inBounds(_ value: Int) -> Bool {
    return value >= 0 && value <= 6
  }
}