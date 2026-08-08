//
//  StorageManager.swift
//  SudokuSolverPro
//
//  Created by Eshan on 08/08/26.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let twoDArrayKey = "saved2DArray"
    
    // MARK: - Save 2D Array
    func save(_ array: [[Int]]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(array)
            UserDefaults.standard.set(data, forKey: twoDArrayKey)
        } catch {
            print("Failed to encode 2D array: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Retrieve 2D Array
    func retrieve() -> [[Int]]? {
        guard let data = UserDefaults.standard.data(forKey: twoDArrayKey) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let array = try decoder.decode([[Int]].self, from: data)
            return array
        } catch {
            print("Failed to decode 2D array: \(error.localizedDescription)")
            return nil
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: twoDArrayKey)
    }
}
