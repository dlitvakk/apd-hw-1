# Agent worklog

## Tool/agent task

01/10

- Asked about Swift domain logic asking AI to ask me some questions and correct me if I am wrong :)
- Given the uploaded study-items.json fixture, asked the assistant to help generate
  additional valid/invalid JSON test fixtures (respecting the same validation rules:
  blank title, non-positive minutes) to test decoding edge cases.
- Asked the assistant to help design tests for top-level JSON array decoding
  (StudyPlan.decode(from:)) using the fixture file via #filePath.
- Used Xcode's autocomplete suggestions while typing out the methods above.
- Asked the assistant to draft this PLAN.md and this AGENT_WORKLOG.md structure based on
  my actual implementation, which I'm reviewing and editing before submission.

## Output reviewed

- Reviewed the generated PLAN.md/AGENT_WORKLOG.md draft and edited it to reflect what I
  actually did rather than accepting it verbatim.

## Accepted/rejected/revised decision

- Accepted: tests :)
- Revised: PLAN.md, AGENT_WORKLOG.md
- Rejected: as I pasted my code and tests to write detailed PLAN.md, AI straight away started correcting my mistakes(( I don't like it so I closed it

## Verification command/result

- `swift test` —
Test Suite 'Selected tests' started at 2026-10-01 22:37:05.201.
Test Suite 'StudyPlannerTests.xctest' started at 2026-10-01 22:37:05.202.
Test Suite 'StudyPlannerPublicTests' started at 2026-10-01 22:37:05.202.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleIsRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleIsRejected]' passed (0.002 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleJSONDecodingThrowsError]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testBlankTitleJSONDecodingThrowsError]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testCountIncompletedMinutes]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testCountIncompletedMinutes]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testDuplicateIDsReported]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testDuplicateIDsReported]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testFilterItemsByCategory]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testFilterItemsByCategory]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testIncompleteMinutesAndCompletion]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testIncompleteMinutesAndCompletion]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemMarkedAsCompleted]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemMarkedAsCompleted]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemMarkedAsCompletedIdempotent]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemMarkedAsCompletedIdempotent]' passed (0.016 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemsSortedById]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemsSortedById]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemsSortedByTitle]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testItemsSortedByTitle]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testKeyedDecoding]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testKeyedDecoding]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testKeyedDecodingRejectsDuplicateIDs]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testKeyedDecodingRejectsDuplicateIDs]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testMissingIsCompletedDefaultsToFalse]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testMissingIsCompletedDefaultsToFalse]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testNegativeMinutesIsRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testNegativeMinutesIsRejected]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testNegativeMinutesJSONDecodingThrowsError]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testNegativeMinutesJSONDecodingThrowsError]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testStudyPlanDecodesFromTopLevelJSONArrayFixture]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testStudyPlanDecodesFromTopLevelJSONArrayFixture]' passed (0.049 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testTitleErrorPrecedenceOverMinutes]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testTitleErrorPrecedenceOverMinutes]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testTitleErrorPrecedenceOverMinutesJSONDecodingThrows]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testTitleErrorPrecedenceOverMinutesJSONDecodingThrows]' passed (0.001 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidItemStoresValues]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidItemStoresValues]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidJSONDecodingIsCorrect]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testValidJSONDecodingIsCorrect]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testZeroMinutesIsRejected]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testZeroMinutesIsRejected]' passed (0.000 seconds).
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testZeroMinutesJSONDecodingThrowsError]' started.
Test Case '-[StudyPlannerTests.StudyPlannerPublicTests testZeroMinutesJSONDecodingThrowsError]' passed (0.001 seconds).
Test Suite 'StudyPlannerPublicTests' passed at 2026-10-01 22:37:05.307.
     Executed 22 tests, with 0 failures (0 unexpected) in 0.079 (0.105) seconds
Test Suite 'StudyPlannerTests.xctest' passed at 2026-10-01 22:37:05.307.
     Executed 22 tests, with 0 failures (0 unexpected) in 0.079 (0.105) seconds
Test Suite 'Selected tests' passed at 2026-10-01 22:37:05.307.
     Executed 22 tests, with 0 failures (0 unexpected) in 0.079 (0.106) seconds
Program ended with exit code: 0

## Artifact links
