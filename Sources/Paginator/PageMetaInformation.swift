//
// price
// Copyright © 2020 Heads and Hands. All rights reserved.
//

import Foundation

public struct PageMetaInformation {
    // MARK: Public

    public let isLoadProgress: Bool
    public let error: PaginatorError?
    public let isFinished: Bool
    public let isFirstPage: Bool
    public let isLoadedEmptyPage: Bool
    public let refreshMode: RefreshMode?
    
    public var nextPayload: PaginatorPagePayload?

    // MARK: Internal

    static var initial: Self {
        PageMetaInformation(
            isLoadProgress: false,
            error: nil,
            isFinished: false,
            isFirstPage: true,
            isLoadedEmptyPage: false,
            refreshMode: nil,
            nextPayload: nil
        )
    }

    func with(nextPayload: PaginatorPagePayload?) -> Self {
        PageMetaInformation(
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode,
            nextPayload: nextPayload
        )
    }

    func with(isLoadProgress: Bool) -> Self {
        PageMetaInformation(
            isLoadProgress: isLoadProgress,
            error: isLoadProgress ? nil : error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode,
            nextPayload: nextPayload
        )
    }

    func with(error: PaginatorError?) -> Self {
        PageMetaInformation(
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode,
            nextPayload: nextPayload
        )
    }

    func with(isFinished: Bool) -> Self {
        PageMetaInformation(
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode,
            nextPayload: nextPayload
        )
    }

    func with(isFirstPage: Bool) -> Self {
        PageMetaInformation(
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode,
            nextPayload: nextPayload
        )
    }

    func with(isLoadedEmptyPage: Bool) -> Self {
        PageMetaInformation(
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode,
            nextPayload: nextPayload
        )
    }

    func with(refreshMode: RefreshMode?) -> Self {
        PageMetaInformation(
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode,
            nextPayload: nextPayload
        )
    }
}
