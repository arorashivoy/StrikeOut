//
//  ModelData.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
	@Published var checkLists: [CheckList] = []
	@Published var listSelector: UUID?
    
    
//    To load and save data
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data : Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do{
            data = try Data(contentsOf: file)
        }catch{
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do{
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }catch{
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    
    func save(to filename: String) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self.checkLists) else { fatalError("Error encoding data") }
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do{
            try data.write(to: file)
        }catch{
            fatalError("Couldn't write to the \(filename)")
        }
    }
}
