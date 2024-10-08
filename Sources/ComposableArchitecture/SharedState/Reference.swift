#if canImport(Combine)
  import Combine
#endif

protocol Reference<Value>: AnyObject, CustomStringConvertible, Sendable {
  associatedtype Value: Sendable
  var value: Value { get set }

  func access()
  func withMutation<T>(_ mutation: () throws -> T) rethrows -> T
  #if canImport(Combine)
    var publisher: AnyPublisher<Value, Never> { get }
  #endif
}

extension Reference {
  var valueType: Any.Type {
    Value.self
  }
}
