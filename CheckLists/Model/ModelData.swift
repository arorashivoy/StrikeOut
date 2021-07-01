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
    var fileName: String = "ListsData.json"
    
//    To get documents folder
    
    private static var documentsFolder: URL {
            do {
                return try FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
            } catch {
                fatalError("Can't find documents directory.")
            }
        }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent(ModelData().fileName)
        }
    //    To load and save data
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                DispatchQueue.main.async {
                    self?.checkLists = [CheckList.data]
                }
                return
            }
            guard let lists = try? JSONDecoder().decode([CheckList].self, from: data) else {
                fatalError("Can't decode saved Lists data.")
            }
            DispatchQueue.main.async {
                self?.checkLists = lists
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let checkLists = self?.checkLists else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(checkLists) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
