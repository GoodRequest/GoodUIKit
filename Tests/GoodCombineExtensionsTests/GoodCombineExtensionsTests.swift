import XCTest
import GoodUIKitCombine
import Combine
import UIKit

class GoodCombineExtensionsTests: XCTestCase {

    func testButtonPublisher() {
        var cancellables = Set<AnyCancellable>()
        let button = UIButton()
        let exp = expectation(description: "Waiting for buttonclick")
        var values = [Int]()

        button.gr.publisher(for: .touchUpInside)
            .handleEvents(receiveSubscription: { _ in
                print("Subscribed")
                values.append(1)
                exp.fulfill()
            })
            .sink { _ in }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
        XCTAssertEqual(values, [1], "Button publisher not working proprerly")
    }

}
