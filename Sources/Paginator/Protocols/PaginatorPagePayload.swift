import Foundation

public protocol PaginatorPagePayload: Encodable {
    var isFirstPage: Bool { get }
    var nextPagePayload: PaginatorPagePayload { get }

    static func make() -> Self

    func isNeedLoad(nextPayload: PaginatorPagePayload) -> Bool
    func isFinished(pageMeta: PaginatorPageMeta) -> Bool
    
    mutating func reduceOffset(by: Int)
    mutating func resetOffset()
}
