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
    typealias MoneyNoteRecord2 = (Int, String, String, String, String, Int, String, String)
    
    
    // SQLite 연결 및 초기화
    lazy var fmdb: FMDatabase! = {
        let fileMgr = FileManager.default
        
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let dbPath = docPath!.appendingPathComponent("moneyNote3.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "moneyNote3", ofType: "sqlite")
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
    func find(date: String) -> [MoneyNoteRecord] {
        // 반환할 데이터 담을 [DepartRecord] 타입의 객체 정의
        var spendList = [MoneyNoteRecord]()
        do {
            let sql = """
                SELECT row, contents, icon, spendorsave, date, price
                FROM note
                WHERE date = ?
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: [date])
            print(rs)
            while rs.next() {
                let row = rs.int(forColumn: "row")
                print(row)
                let contents = rs.string(forColumn: "contents")
                print(contents!)
                let icon = rs.string(forColumn: "icon")
                print(icon!)
                let spendorsave = rs.string(forColumn: "spendorsave")
                print(spendorsave!)
                let date = rs.string(forColumn: "date")
                print(date!)
                let price = rs.int(forColumn: "price")
                print(price)
                //let totalMoney = rs.int(forColumn: "totalMoney")
                
                spendList.append(( Int(row), contents!, icon!, spendorsave!, date!, Int(price) ))
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return spendList
    }
    
    // 총 잔액용
//    func findTotal() -> Int {
//        var totalMoney = 0
//        do {
//            let sql = """
//                SELECT totalMoney
//                FROM totalMoney
//            """
//            let rs = try self.fmdb.executeQuery(sql, values: nil)
//            while rs.next() {
//                let ttm = rs.int(forColumn: "totalMoney")
//                totalMoney = Int(ttm)
//            }
//        } catch let error as NSError {
//            print("failed: \(error.localizedDescription)")
//        }
//        return totalMoney
//    }
    //
    
    func get(date: String) -> MoneyNoteRecord? {
        // 날짜를 기준으로 값을 가져온다.
        let sql = """
            SELECT row, contents, icon, spendorsave, date, price
            FROM note
            WHERE date = ?
        """

        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [date])
        
        // 결과 받기
        if let _rs = rs {
            _rs.next()
            
            let row = _rs.int(forColumn: "row")
            let content = _rs.string(forColumn: "contents")
            let icon = _rs.string(forColumn: "icon")
            let spendorsave = _rs.string(forColumn: "spendorsave")
            let date = _rs.string(forColumn: "date")
            let price = _rs.int(forColumn: "price")
            
            return ( Int(row), content!, icon!, spendorsave!, date!, Int(price) )
            
        } else {
            return nil
        }
    }
    
    func get(row: Int, date: String) -> MoneyNoteRecord? {
        // 상세 보기에 사용될 함수 row값을 넘겨 받아 가져온다.
        let sql = """
            SELECT row, contents, icon, spendorsave, date, price
            FROM note
            WHERE row = ? and date = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [row,date])
        
        // 결과 받기
        if let _rs = rs {
            _rs.next()
            
            let row = _rs.int(forColumn: "row")
            let content = _rs.string(forColumn: "contents")
            let icon = _rs.string(forColumn: "icon")
            let spendorsave = _rs.string(forColumn: "spendorsave")
            let date = _rs.string(forColumn: "date")
            let price = _rs.int(forColumn: "price")
            
            return ( Int(row), content!, icon!, spendorsave!, date!, Int(price) )
            
        } else {
            return nil
        }
    }
    
    // 일간 지출, 수입 가져오는 쿼리
    func getDailySpendTotal(date: String, spendorsave: String) -> Int {
        let sql = """
            select sum(price) as totalspend
            from note
            where date = ? and spendorsave = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [date,spendorsave])
        
        // 결과 받기
        if let _rs = rs {
            _rs.next()
            
            let totalspend = _rs.int(forColumn: "totalspend")
            
            return Int(totalspend)
            
        } else {
            return 0
        }
    }
    
    // 월간 지출, 수입 가져오는 쿼리
    func getMonthlySpendTotal(date: String, spendorsave: String) -> Int {
        let sql = """
            select sum(price) as totalspend
            from note
            where yearMonth = ? and spendorsave = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [date,spendorsave])
        
        // 결과 받기
        if let _rs = rs {
            _rs.next()
            
            let totalspend = _rs.int(forColumn: "totalspend")
            
            return Int(totalspend)
            
        } else {
            return 0
        }
    }
    
    // 연간 지출, 수입 가져오는 쿼리
    func getYearSpendTotal(date: String, spendorsave: String) -> Int {
        let sql = """
            select sum(price) as totalspend
            from note
            where year = ? and spendorsave = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [date,spendorsave])
        
        // 결과 받기
        if let _rs = rs {
            _rs.next()
            
            let totalspend = _rs.int(forColumn: "totalspend")
            
            return Int(totalspend)
            
        } else {
            return 0
        }
    }
    
//    func getALL() -> [MoneyNoteRecord2] {
//        // 반환할 데이터 담을 [DepartRecord] 타입의 객체 정의
//        var spendList = [MoneyNoteRecord2]()
//        do {
//            let sql = """
//                SELECT *
//                FROM note
//            """
//
//            let rs = try self.fmdb.executeQuery(sql, values: nil)
//            print(rs)
//            while rs.next() {
//                let row = rs.int(forColumn: "row")
//                print(row)
//                let contents = rs.string(forColumn: "contents")
//                print(contents!)
//                let icon = rs.string(forColumn: "icon")
//                print(icon!)
//                let spendorsave = rs.string(forColumn: "spendorsave")
//                print(spendorsave!)
//                let date = rs.string(forColumn: "date")
//                print(date!)
//                let price = rs.int(forColumn: "price")
//                print(price)
//                let year = rs.string(forColumn: "year")
//                print(year!)
//                let yearMonth = rs.string(forColumn: "yearMonth")
//                print(yearMonth!)
//                //let totalMoney = rs.int(forColumn: "totalMoney")
//
//                spendList.append(( Int(row), contents!, icon!, spendorsave!, date!, Int(price), year!, yearMonth! ))
//            }
//        } catch let error as NSError {
//            print("failed: \(error.localizedDescription)")
//        }
//        return spendList
//    }
    
    // 노트 작성하기
    func create(content: String!, icon: String!, spendorsave: String!, date: String!, price: Int!) -> Bool {
        
        // 날짜를 받은 다음 공백 기준으로 나눔
        // ex) 2018년 6월 25일
        // 2018년 > year
        // 2018년 6월 > yearMonth로!
        
        let makingYearMonth = date.components(separatedBy: " ")
        let year: String = makingYearMonth[0]
        
        var yearMonth: String = makingYearMonth[0]
        yearMonth.append(makingYearMonth[1])
        
        //
        do {
            let sql = """
                INSERT INTO note (contents, icon, spendorsave, date, price, year, yearMonth)
                VALUES (?,?,?,?,?,?,?)
            """
            
            try self.fmdb.executeUpdate(sql, values: [content, icon, spendorsave, date, price, year, yearMonth])
            return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    // 노트 수정하기
    func update(content: String!, icon: String!, spendorsave: String!, date: String!, price: Int!, row: Int!) -> Bool {
        
        // 날짜를 받은 다음 공백 기준으로 나눔
        // ex) 2018년 6월 25일
        // 2018년 > year
        // 2018년 6월 > yearMonth로!
        
        let makingYearMonth = date.components(separatedBy: " ")
        let year: String = makingYearMonth[0]
        
        var yearMonth: String = makingYearMonth[0]
        yearMonth.append(makingYearMonth[1])
        
        //
        do {
            let sql = """
                UPDATE note SET contents = ?, icon = ?, spendorsave = ?, date = ? , price = ? , year = ?, yearMonth = ?
                WHERE row = ?
            """
            
            try self.fmdb.executeUpdate(sql, values: [content, icon, spendorsave, date, price, year, yearMonth, row])
            return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    // 노트 삭제하기
    func remove(row: Int!) -> Bool {
        do {
            let sql = "DELETE FROM note WHERE row = ?"
            try self.fmdb.executeUpdate(sql, values: [row])
            return true
        } catch let error as NSError {
            print("DELETE Error: \(error.localizedDescription)")
            return false
        }
    }
}
