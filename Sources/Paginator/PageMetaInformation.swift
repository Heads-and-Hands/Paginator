//
// price
// Copyright © 2020 Heads and Hands. All rights reserved.
//

import Foundation

public struct PageMetaInformation {
    // MARK: Public

    public let nextPayload: PaginatorPagePayload?
    public let isLoadProgress: Bool
    public let error: PaginatorError?
    public let isFinished: Bool
    public let isFirstPage: Bool
    public let isLoadedEmptyPage: Bool
    public let refreshMode: RefreshMode?

    // MARK: Internal

    static var initial: Self {
        PageMetaInformation(
            nextPayload: nil,
            isLoadProgress: false,
            error: nil,
            isFinished: false,
            isFirstPage: true,
            isLoadedEmptyPage: false,
            refreshMode: nil
        )
    }

    func with(nextPayload: PaginatorPagePayload?) -> Self {
        PageMetaInformation(
            nextPayload: nextPayload,
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode
        )
    }

    func with(isLoadProgress: Bool) -> Self {
        PageMetaInformation(
            nextPayload: nextPayload,
            isLoadProgress: isLoadProgress,
            error: isLoadProgress ? nil : error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode
        )
    }

    func with(error: PaginatorError?) -> Self {
        PageMetaInformation(
            nextPayload: nextPayload,
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode
        )
    }

    func with(isFinished: Bool) -> Self {
        PageMetaInformation(
            nextPayload: nextPayload,
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode
        )
    }

    func with(isFirstPage: Bool) -> Self {
        PageMetaInformation(
            nextPayload: nextPayload,
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode
        )
    }

    func with(isLoadedEmptyPage: Bool) -> Self {
        PageMetaInformation(
            nextPayload: nextPayload,
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode
        )
    }

    func with(refreshMode: RefreshMode?) -> Self {
        PageMetaInformation(
            nextPayload: nextPayload,
            isLoadProgress: isLoadProgress,
            error: error,
            isFinished: isFinished,
            isFirstPage: isFirstPage,
            isLoadedEmptyPage: isLoadedEmptyPage,
            refreshMode: refreshMode
        )
    }
}
