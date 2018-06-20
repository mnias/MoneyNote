//
//  MoneyNoteDAO.swift
//  MoneyNote
//
//  Created by gyeong hawn Park on 2018. 6. 20..
//  Copyright © 2018년 gyeong hawn Park. All rights reserved.
//

import Foundation

class MoneyNoteDAO {
    // 사용될 튜플 타입
    typealias MoneyNoteRecord = (Int, String, String, String, String, Int)
    
    // SQLite 연결 및 초기화
    lazy var fmdb: FMDatabase! = {
        let fileMgr = FileManager.default
        
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let dbPath = docPath!.appendingPathComponent("moneyNote.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "moneyNote", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        let db = FMDatabase(path: dbPath)
        
        return db
    }()
    
    init() {
        self.fmdb.open()
    }
    deinit {
        self.fmdb.close()
    }
    func find() -> [MoneyNoteRecord] {
        // 반환할 데이터 담을 [DepartRecord] 타입의 객체 정의
        var spendList = [MoneyNoteRecord]()
        do {
            let sql = """
                SELECT row, contents, icon, spendorsave, date, price
                FROM note
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                let row = rs.int(forColumn: "row")
                let contents = rs.string(forColumn: "contents")
                let icon = rs.string(forColumn: "icon")
                let spendorsave = rs.string(forColumn: "spendorsave")
                let date = rs.string(forColumn: "date")
                let price = rs.int(forColumn: "price")
                //let totalMoney = rs.int(forColumn: "totalMoney")
                
                spendList.append(( Int(row), contents!, icon!, spendorsave!, date!, Int(price) ))
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return spendList
    }
    
//    func get(date: String) -> MoneyNoteRecord? {
//        // 날짜를 기준으로 값을 가져온다.
//        let sql = """
//            SELECT row, contents, icon, spendorsave, date, price
//            FROM note
//            WHERE date = ?
//        """
//
//        let rs = self.fmdb.executeQuery(sql, withAr)
//    }
}
