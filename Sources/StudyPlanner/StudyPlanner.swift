import Foundation

public enum StudyCategory: String, Codable, CaseIterable {
    case reading, practice, project
}

public enum StudyPlanError: Error, Equatable {
    case blankTitle
    case nonPositiveEstimatedMinutes
    case duplicateID(String)
    case unknownID(String)
}

public struct StudyItem: Codable, Equatable {
    public let id: String
    public let title: String
    public let estimatedMinutes: Int
    public let category: StudyCategory
    public private(set) var isCompleted: Bool

    public init(
        id: String,
        title: String,
        estimatedMinutes: Int,
        category: StudyCategory,
        isCompleted: Bool = false
    ) throws {
        
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw StudyPlanError.blankTitle
        }
        
        guard estimatedMinutes > 0 else {
            throw StudyPlanError.nonPositiveEstimatedMinutes
        }
        
        self.id = id
        self.title = title
        self.estimatedMinutes = estimatedMinutes
        self.category = category
        self.isCompleted = isCompleted
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, estimatedMinutes, category, isCompleted
    }
    
    public init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let estimatedMinutes = try container.decode(Int.self, forKey: .estimatedMinutes)
        let category = try container.decode(StudyCategory.self, forKey: .category)
        let isCompleted = try container.decodeIfPresent(Bool.self, forKey: .isCompleted) ?? false
        
        try self.init(
            id: id,
            title: title,
            estimatedMinutes: estimatedMinutes,
            category: category,
            isCompleted: isCompleted
        )
    }
    
    mutating func setIsCompleted(_ value: Bool) {
        self.isCompleted = value
    }
}

public struct StudyPlan: Codable, Equatable {
    public private(set) var items: [StudyItem]

    public init(items: [StudyItem]) throws {
        
        var ids = Set<String>()
        
        for item in items {
            guard !ids.contains(item.id) else {
                throw StudyPlanError.duplicateID(item.id)
            }
            
            ids.insert(item.id)
        }
        
        let sorted = items.sorted { left, right in
            if left.title != right.title {
                return left.title < right.title
            } else {
                return left.id < right.id
            }
        }
        
        self.items = sorted
    }

    public static func decode(from data: Data) throws -> StudyPlan {
        fatalError("Implement array decoding")
    }

    public func items(in category: StudyCategory) -> [StudyItem] {
        return items.filter { item in
            item.category == category
        }
    }

    public func incompleteMinutes() -> Int {
        items.filter{ item in
            item.isCompleted == false
        } .reduce(0) { $0 + $1.estimatedMinutes }
    }

    public mutating func markCompleted(id: String) throws {
        guard let index = items.firstIndex(where: { $0.id == id }) else {
            throw StudyPlanError.unknownID(id)
        }
        
        items[index].setIsCompleted(true)
    }

    public mutating func importMerging(_ importedItems: [StudyItem]) throws {
        fatalError("Implement optional bonus")
    }
}
