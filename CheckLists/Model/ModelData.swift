//
//  ModelData.swift
//  CheckLists
//
//  Created by Shivoy Arora on 14/06/21.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    /// creating shared instance to use in AppDelegate
    static let shared = ModelData()
    
    @Published var checkLists: [CheckList] = []
    @Published var listSelector: UUID?
    
    var fileName: String = "ListsData.json"
    
    /// To get documents folder
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
    
    /// to load data
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                DispatchQueue.main.async {
                    self?.checkLists = [CheckList.data]
                }
                return
            }
            guard let lists = try? JSONDecoder().decode([CheckListDTO].self, from: data) else {
                fatalError("Can't decode saved Lists data.")
            }
            DispatchQueue.main.async {
                self?.checkLists = CheckListDTOMapper.map(lists)
            }
        }
    }
    
    /// to save data
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let checkLists = self?.checkLists else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(CheckListMapper.map(checkLists)) else { fatalError("Error encoding data") }
            do {
                let outFile = Self.fileURL
                try data.write(to: outFile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
