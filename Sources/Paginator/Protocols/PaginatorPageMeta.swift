import Foundation

public protocol PaginatorPageMeta {
    func isFinished(for total: Int) -> Bool
    func additionalData() -> PaginatorAdditionalData?
}

public extension PaginatorPageMeta {
    func additionalData() -> PaginatorAdditionalData? {
        nil
    }
}
