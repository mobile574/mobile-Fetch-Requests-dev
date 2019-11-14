//
//  CWBoxedJSON.swift
//  FetchRequests
//
//  Created by Adam Lickel on 11/13/19.
//  Copyright © 2019 Speramus Inc. All rights reserved.
//

import Foundation

@objc(CWBoxedJSON)
public class CWBoxedJSON: NSObject {
    internal let json: CWJSON

    public init(_ json: CWJSON) {
        self.json = json
    }

    @objc
    public var object: Any {
        return json.object
    }

    @objc
    public subscript(key: String) -> CWBoxedJSON? {
        return json[key] as CWBoxedJSON?
    }

    @objc
    public subscript(offset: Int) -> CWBoxedJSON? {
        return json[offset] as CWBoxedJSON?
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CWBoxedJSON else {
            return super.isEqual(object)
        }
        return json == other.json
    }
}

//swiftlint:disable identifier_name

extension CWJSON: _ObjectiveCBridgeable {
    public func _bridgeToObjectiveC() -> CWBoxedJSON {
        return CWBoxedJSON(self)
    }

    public static func _forceBridgeFromObjectiveC(
      _ source: CWBoxedJSON,
      result: inout CWJSON?
    ) {
        result = source.json
    }

    public static func _conditionallyBridgeFromObjectiveC(
      _ source: CWBoxedJSON,
      result: inout CWJSON?
    ) -> Bool {
        result = source.json
        return true
    }

    public static func _unconditionallyBridgeFromObjectiveC(
        _ source: CWBoxedJSON?
    ) -> CWJSON {
      var result: CWJSON?
      _forceBridgeFromObjectiveC(source!, result: &result)
      return result!
    }
}
