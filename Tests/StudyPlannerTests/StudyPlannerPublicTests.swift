import XCTest
@testable import StudyPlanner

final class StudyPlannerPublicTests: XCTestCase {
    func testValidItemStoresValues() throws {
        let item = try StudyItem(
            id: "read-1",
            title: "Read Swift",
            estimatedMinutes: 30,
            category: .reading
        )

        XCTAssertEqual(item.id, "read-1")
        XCTAssertFalse(item.isCompleted)
    }

    func testBlankTitleIsRejected() {
        XCTAssertThrowsError(
            try StudyItem(id: "x", title: "  \n", estimatedMinutes: 10, category: .practice)
        )
    }

    func testIncompleteMinutesAndCompletion() throws {
        let first = try StudyItem(id: "a", title: "A", estimatedMinutes: 10, category: .reading)
        let second = try StudyItem(id: "b", title: "B", estimatedMinutes: 20, category: .practice)
        var plan = try StudyPlan(items: [first, second])

        try plan.markCompleted(id: "a")

        XCTAssertEqual(plan.incompleteMinutes(), 20)
    }
    
    func testNegativeMinutesIsRejected() {
        XCTAssertThrowsError(
            try StudyItem(id: "x", title: "A", estimatedMinutes: -10, category: .practice)
        )
    }
    
    func testZeroMinutesIsRejected() {
        XCTAssertThrowsError(
            try StudyItem(id: "x", title: "A", estimatedMinutes: 0, category: .practice)
        )
    }
    
    func testTitleErrorPrecedenceOverMinutes() {
        XCTAssertThrowsError(
            try StudyItem(id: "x", title: "   ", estimatedMinutes: -5, category: .practice)
        ) {
            error in
            XCTAssertEqual(error as? StudyPlanError, .blankTitle)
        }
    }
    
    func testValidJSONDecodingIsCorrect() throws {
        let json = """
        {
            "id": "x",
            "title": "A",
            "estimatedMinutes": 30,
            "category": "reading",
            "isCompleted": false
        }
        """
        let data = json.data(using: .utf8)!

        let item = try JSONDecoder().decode(StudyItem.self, from: data)

        XCTAssertEqual(item.id, "x")
        XCTAssertEqual(item.title, "A")
        XCTAssertEqual(item.estimatedMinutes, 30)
        XCTAssertEqual(item.category, .reading)
        XCTAssertFalse(item.isCompleted)
    }
    
    func testBlankTitleJSONDecodingThrowsError() {
        let json = """
        {
            "id": "x",
            "title": "   ",
            "estimatedMinutes": 10,
            "category": "practice",
            "isCompleted": false
        }
        """
        let data = json.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(StudyItem.self, from: data)) { error in
            XCTAssertEqual(error as? StudyPlanError, .blankTitle)
        }
    }
    
    func testZeroMinutesJSONDecodingThrowsError() {
        let json = """
        {
            "id": "x",
            "title": "A",
            "estimatedMinutes": 0,
            "category": "practice",
            "isCompleted": false
        }
        """
        let data = json.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(StudyItem.self, from: data)) { error in
            XCTAssertEqual(error as? StudyPlanError, .nonPositiveEstimatedMinutes)
        }
    }
    
    func testNegativeMinutesJSONDecodingThrowsError() {
        let json = """
        {
            "id": "x",
            "title": "A",
            "estimatedMinutes": -10,
            "category": "practice",
            "isCompleted": false
        }
        """
        let data = json.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(StudyItem.self, from: data)) { error in
            XCTAssertEqual(error as? StudyPlanError, .nonPositiveEstimatedMinutes)
        }
    }
    
    func testTitleErrorPrecedenceOverMinutesJSONDecodingThrows() {
        let json = """
        {
            "id": "x",
            "title": "    ",
            "estimatedMinutes": -10,
            "category": "practice",
            "isCompleted": false
        }
        """
        let data = json.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(StudyItem.self, from: data)) { error in
            XCTAssertEqual(error as? StudyPlanError, .blankTitle)
        }
    }
    
    func testMissingIsCompletedDefaultsToFalse() throws {
        let json = """
        {
            "id": "x",
            "title": "Valid title",
            "estimatedMinutes": 10,
            "category": "project"
        }
        """
        let data = json.data(using: .utf8)!

        let item = try JSONDecoder().decode(StudyItem.self, from: data)

        XCTAssertFalse(item.isCompleted)
    }
    
    func testDuplicateIDsReported() throws {
        let a = try StudyItem(id: "x", title: "A", estimatedMinutes: 10, category: .reading)
        let b = try StudyItem(id: "y", title: "B", estimatedMinutes: 10, category: .reading)
        let c = try StudyItem(id: "x", title: "B", estimatedMinutes: 10, category: .reading)
        
        XCTAssertThrowsError(try StudyPlan(items: [a, b, c])) { error in
            XCTAssertEqual(error as? StudyPlanError, .duplicateID("x"))
        }
    }
    
    func testItemsSortedByTitle() throws {
        let a = try StudyItem(id: "x", title: "A", estimatedMinutes: 10, category: .reading)
        let b = try StudyItem(id: "y", title: "C", estimatedMinutes: 10, category: .reading)
        let c = try StudyItem(id: "z", title: "B", estimatedMinutes: 10, category: .reading)
        
        let plan = try StudyPlan(items: [a, b, c])
        
        XCTAssertEqual(plan.items.map { $0.title }, ["A", "B", "C"])
    }
    
    func testItemsSortedById() throws {
        let a = try StudyItem(id: "x", title: "A", estimatedMinutes: 10, category: .reading)
        let b = try StudyItem(id: "z", title: "B", estimatedMinutes: 10, category: .reading)
        let c = try StudyItem(id: "y", title: "B", estimatedMinutes: 10, category: .reading)
        
        let plan = try StudyPlan(items: [a, b, c])
        
        XCTAssertEqual(plan.items.map { $0.id }, ["x", "y", "z"])
    }
}
