//
//  NameDescribable.swift
//  
//
//  Created by Dominik Pethö on 4/30/19.
//

import Foundation
import GRUICompatible

/**
Name describable allow your to take typename from any type extending the protocol
*/
public protocol NameDescribable {

    var typeName: String { get }
    static var typeName: String { get }

}

public extension NameDescribable {

    /**
    Typename of NSObject. Useful for example when diffing
    */
    var typeName: String {
        return String(describing: type(of: self))
    }

    /**
    Typename of NSObject. Useful for example when diffing
    */
    static var typeName: String {
        return String(describing: type(of: self))
    }

}

public extension GRActive where Base: NSObject {

    /**
    Typename of NSObject. Useful for example when diffing
    */
    var typeName: String {
        return String(describing: type(of: base))
    }

    static var typeName: String {
        return String(describing: Base.self)
    }

}

public extension GRActive where Base: Collection {

    /**
    Typename of NSObject. Useful for example when diffing
    */
    var typeName: String {
        return String(describing: type(of: base))
    }

    static var typeName: String {
        return String(describing: Base.self)
    }

}
