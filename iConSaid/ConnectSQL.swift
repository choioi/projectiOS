//
//  ConnectSQL.swift
//  iConSaid
//
//  Created by Bộp Bộp on 5/8/16.
//  Copyright © 2016 Bộp Bộp. All rights reserved.
//

import Foundation

func Select( query:String,  database:COpaquePointer)->COpaquePointer{
    var statement:COpaquePointer = nil
    sqlite3_prepare_v2(database, query, -1, &statement, nil)
    return statement
}

func Query( sql:String, database:COpaquePointer){
    var errMsg:UnsafeMutablePointer<Int8> = nil
    let result = sqlite3_exec(database, sql, nil, nil, &errMsg);
    if (result != SQLITE_OK) {
        sqlite3_close(database)
        return
    }
}

func Connect_DB_Sqlite( dbName:String, type:String)->COpaquePointer{
    var database:COpaquePointer = nil
    var dbPath:String = ""
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    let storePath : NSString = documentsPath.stringByAppendingPathComponent(dbName)
    let fileManager : NSFileManager = NSFileManager.defaultManager()
    dbPath = NSBundle.mainBundle().pathForResource(dbName , ofType:type)!
    do {
        try fileManager.copyItemAtPath(dbPath, toPath: storePath as String)
    } catch {
    }
    let result = sqlite3_open(dbPath, &database)
    if result != SQLITE_OK {
        sqlite3_close(database)
    }
    return database
}