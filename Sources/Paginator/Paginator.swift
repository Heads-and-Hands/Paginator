//
// price
// Copyright © 2020 Heads and Hands. All rights reserved.
//

import Combine
import Foundation
import NetworkLayer

public class Paginator {
    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public func nextPagePayload<Payload: PaginatorPagePayload>() -> Payload? {
        currentPageMeta.nextPayload as? Payload
    }

    public func nextPage<Payload: PaginatorPagePayload, Response: ApiClientResponse, Entity>(
        payload: Payload,
        refreshMode: RefreshMode?,
        updateBlock: @escaping (_ list: [Entity], PageMetaInformation) -> Void,
        makeRequest: (_ pagePayload: Payload) -> ApiClient.Result<Response>
    ) where Response.ResponseData: Collection, Response.ResponseData.Element == Entity {
        guard let (meta, payload) = prepare(payload: payload, refreshMode: refreshMode) else {
            return
        }

        request = perform(
            payload: payload,
            refreshMode: refreshMode,
            meta: meta,
            updateBlock: updateBlock,
            publisher: makeRequest(payload).map { (Array($0), nil) }.eraseToAnyPublisher()
        )
    }

    public func nextPage<Payload: PaginatorPagePayload, Response: ApiClientResponse, Entity>(
        payload: Payload,
        refreshMode: RefreshMode?,
        updateBlock: @escaping (_ list: [Entity], PageMetaInformation) -> Void,
        makeRequest: (_ pagePayload: Payload) -> ApiClient.Result<Response>
    ) where Response.ResponseData: PaginatorListHolder, Response.ResponseData.Entity == Entity {
        guard let (meta, payload) = prepare(payload: payload, refreshMode: refreshMode) else {
            return
        }

        request = perform(
            payload: payload,
            refreshMode: refreshMode,
            meta: meta,
            updateBlock: updateBlock,
            publisher: makeRequest(payload).map { ($0.list, $0.meta) }.eraseToAnyPublisher()
        )
    }

    public func reduceOffset(by value: Int) {
        currentPageMeta.nextPayload?.reduceOffset(by: value)
    }

    public func resetOffset() {
        currentPageMeta.nextPayload?.resetOffset()
    }

    // MARK: Private

    private var request: AnyCancellable?

    private var currentPageMeta: PageMetaInformation = .initial {
        didSet {
            request = nil
        }
    }

    private var finished: Bool {
        currentPageMeta.isFinished
    }

    private var isLoading: Bool {
        currentPageMeta.isLoadProgress
    }

    private func prepare<Payload: PaginatorPagePayload>(
        payload: Payload,
        refreshMode: RefreshMode?
    ) -> (meta: PageMetaInformation, payload: Payload)? {
        var meta: PageMetaInformation?
        var result: Payload?

        if let refreshMode = refreshMode, payload.isFirstPage {
            request?.cancel()

            meta = PageMetaInformation.initial
                .with(isLoadProgress: true)
                .with(refreshMode: refreshMode)

            result = payload

        } else if !(finished || isLoading), request == nil {
            meta = currentPageMeta
                .with(isLoadProgress: true)
                .with(refreshMode: nil)

            if let nextPayload = currentPageMeta.nextPayload as? Payload {
                meta = meta?.with(isFirstPage: false)
                result = payload.isNeedLoad(nextPayload: nextPayload) ? nextPayload : nil
            } else if payload.isFirstPage {
                meta = meta?.with(isFirstPage: true)
                result = payload
            }
        }

        if let meta = meta, let result = result {
            return (meta, result)
        } else {
            return nil
        }
    }

    private func perform<Payload: PaginatorPagePayload, ApiError: PaginatorError, Entity>(
        payload: Payload,
        refreshMode _: RefreshMode?,
        meta: PageMetaInformation,
        updateBlock: @escaping (_ list: [Entity], PageMetaInformation) -> Void,
        publisher: AnyPublisher<(list: [Entity], loadedMeta: PaginatorPageMeta?), ApiError>
    ) -> AnyCancellable {
        updateBlock([], meta)

        return publisher
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] result in
                    defer {
                        self?.request = nil
                    }

                    guard case let .failure(error) = result else {
                        return
                    }

                    let errorMeta = meta
                        .with(error: error)
                        .with(isLoadProgress: false)

                    // Передача состояния ошибки
                    updateBlock([], errorMeta)
                },
                receiveValue: { [weak self] output in
                    guard let self = self else {
                        return
                    }

                    let nextPayload = payload.nextPagePayload
                    let finished: Bool

                    if let meta = output.loadedMeta {
                        finished = output.list.isEmpty || payload.isFinished(pageMeta: meta)
                    } else {
                        finished = true
                    }

                    let completeMeta = meta
                        .with(isLoadProgress: false)
                        .with(nextPayload: nextPayload)
                        .with(isFinished: finished)
                        .with(isLoadedEmptyPage: output.list.isEmpty)

                    // Передача состояния успеха
                    updateBlock(output.list, completeMeta)

                    self.currentPageMeta = completeMeta
                }
            )
    }
}

extension ApiClientError: PaginatorError {}
