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
}
