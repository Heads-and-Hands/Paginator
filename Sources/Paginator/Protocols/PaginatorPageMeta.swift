import Foundation

public protocol PaginatorPageMeta {
    func isFinished(for total: Int) -> Bool
}
