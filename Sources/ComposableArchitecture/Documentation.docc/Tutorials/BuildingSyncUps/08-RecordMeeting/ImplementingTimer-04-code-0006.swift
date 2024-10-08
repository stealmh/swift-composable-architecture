import ComposableArchitecture
import XCTest

@testable import SyncUps

final class RecordMeetingTests: XCTestCase {
  func testTimerFinishes() async {
    let clock = TestClock()
    let syncUp = SyncUp(
      id: SyncUp.ID(),
      attendees: [
        Attendee(id: Attendee.ID(), name: "Blob"),
        Attendee(id: Attendee.ID(), name: "Blob Jr"),
      ],
      duration: .seconds(4),
      title: "Morning Sync"
    )
    let store = await TestStore(
      initialState: RecordMeeting.State(syncUp: Shared(syncUp))
    ) {
      RecordMeeting()
    } withDependencies: {
      $0.continuousClock = clock
    }

    await store.send(.onAppear)
    await clock.advance(by: .seconds(1))
  }
}
