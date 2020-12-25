import Foundation

public protocol PaginatorListHolder {
    associatedtype Entity

    var list: [Entity] { get }
    var meta: PaginatorPageMeta? { get }
}
