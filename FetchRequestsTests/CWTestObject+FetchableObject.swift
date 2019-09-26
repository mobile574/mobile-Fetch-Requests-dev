//
//  File.swift
//  FetchRequests-iOSTests
//
//  Created by Adam Lickel on 3/29/19.
//  Copyright © 2019 Speramus Inc. All rights reserved.
//

import Foundation
import FetchRequests

// MARK: - CWFetchableObjectProtocol

private class Token: CWInvalidatableToken {
    init(parent: CWTestObject) {
        self.parent = parent
    }

    let uuid = UUID()
    private weak var parent: CWTestObject?

    func invalidate() {
        parent?.dataObservers[uuid] = nil
        parent = nil
    }

    deinit {
        invalidate()
    }
}

extension CWTestObject: CWFetchableObjectProtocol {
    func observeDataChanges(_ handler: @escaping (CWTestObject) -> Void) -> CWInvalidatableToken {
        let token = Token(parent: self)
        dataObservers[token.uuid] = handler
        return token
    }

    func observeIsDeletedChanges(_ handler: @escaping (CWTestObject) -> Void) -> CWInvalidatableToken {
        return self.observe(\.isDeleted, options: [.old, .new]) { object, change in
            guard let old = change.oldValue, let new = change.newValue, old != new else {
                return
            }
            handler(object)
        }
    }

    static func entityID(from data: RawData) -> ID? {
        return data["id"] as? ID
    }
}

// MARK: - Event Notifications

extension CWTestObject {
    static func objectWasCreated() -> Notification.Name {
        return Notification.Name("CWTestObject.objectWasCreated")
    }

    static func dataWasCleared() -> Notification.Name {
        return Notification.Name("CWTestObject.dataWasCleared")
    }
}
