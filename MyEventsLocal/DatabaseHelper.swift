//
//  DatabaseHelper.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 11/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import Foundation
import RealmSwift

struct DatabaseHelper {
	
	static private let realm: Realm? = try? Realm()
	
	static func add(object: Object, update: Bool) throws{
		do{
			try realm?.write{
				realm?.add(object, update: update)
			}
		}catch let error{
			throw RealmError.writeFailed(with: error)
		}
	}

	static func query(for type: Object.Type, with filter: String) throws -> Results<Object>?{
		guard let results = realm?.objects(type), results.count > 0 else { throw RealmError.queryFailed(with: nil)}
		return results
	}
	
	static func delete(object: Object) throws{
		do{
			try realm?.write{
				realm?.delete(object)
			}
		}catch let error{
			throw RealmError.deleteFailed(with: error)
		}
	}
	

	enum RealmError: Error{
		case writeFailed(with : Any)
		case deleteFailed(with: Any)
		case queryFailed(with: Any?)

	}
}
