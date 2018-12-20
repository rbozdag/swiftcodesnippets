import Foundation
import XCTest

public class Node<Element> {
    var value: Element?
    private(set) var next: Node<Element>?
    private(set) var previous: Node<Element>?

    public init(value: Element? = nil, next: Node<Element>? = nil, previous: Node<Element>? = nil) {
        self.value = value
        self.next = next
        self.previous = previous
    }

    public func setNext(_ next: Node?) {
        self.next = next
    }

    public func setPrevious(_ previous: Node?) {
        self.previous = previous
    }

    deinit {
        print("deinit")
    }
}

public class DoublyLinkedList<Element> {
    private var head: Node<Element>?
    private var tail: Node<Element>?

    public var isEmpty: Bool { return head == nil }
    public var first: Element? { return head?.value }
    public var last: Element? { return tail?.value }

    public func description() -> String {
        guard !isEmpty else {
            return "_empty_DoublyLinkedList"
        }

        var log = ""
        var current: Node? = head
        while current != nil {
            if let value = current!.value {
                log += String(describing: value)
            } else {
                log += "_empty_"
            }

            current = current!.next

            if current != nil {
                log += ", "
            }
        }

        return log
    }

    public func insertAfter(node: Node<Element>, newNode: Node<Element>) {
        newNode.setPrevious(node)
        if let nextNode = node.next {
            newNode.setNext(nextNode)
        } else {
            tail = newNode
        }
        node.setNext(newNode)
    }

    public func insertBefore(node: Node<Element>, newNode: Node<Element>) {
        newNode.setNext(node)
        if let previousNode = node.previous {
            newNode.setPrevious(previousNode)
        } else {
            head = newNode
        }
        node.setPrevious(newNode)
    }

    public func insertFirst(_ newValue: Element) {
        let newNode = createNode(value: newValue)

        if isEmpty {
            initializeFirstNode(newNode)
        } else {
            insertBefore(node: head!, newNode: newNode)
        }
    }

    public func append(_ newValue: Element) {
        let newNode = createNode(value: newValue)

        if isEmpty {
            initializeFirstNode(newNode)
        } else {
            insertAfter(node: tail!, newNode: newNode)
        }
    }

    private func initializeFirstNode(_ node: Node<Element>) {
        head = node
        tail = node
    }

    private func createNode(value: Element?) -> Node<Element> {
        let newNode = Node(value: value)
        return newNode
    }

    @discardableResult
    public func removeFirst() -> Element? {
        let oldHead = head

        head = head?.next
        head?.setPrevious(nil)
        oldHead?.setNext(nil)

        if head == nil {
            tail = nil
        }

        return oldHead?.value
    }

    @discardableResult
    public func removeLast() -> Element? {
        let oldTail = tail

        tail = oldTail?.previous
        tail?.setNext(nil)
        oldTail?.setPrevious(nil)

        if tail == nil {
            head = nil
        }

        return oldTail?.value
    }

    public func clear() {
        self.head = nil
        self.tail = nil
    }
}


// MARK: - Unit Test
class DoublyLinkedListTest: XCTestCase {
    var list: DoublyLinkedList<String>!

    override func setUp() {
        list = DoublyLinkedList<String>()
    }

    func testInitialize() {
        XCTAssert(list.isEmpty)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
    }

    func testRemoveLast() {
        list.append("A")
        list.append("B")
        list.append("C")

        var removed = list.removeLast()
        XCTAssertEqual(removed, "C")
        XCTAssertEqual(list.first, "A")
        XCTAssertEqual(list.last, "B")

        removed = list.removeLast()
        XCTAssertEqual(removed, "B")
        XCTAssertEqual(list.first, "A")
        XCTAssertEqual(list.last, "A")

        removed = list.removeLast()
        XCTAssertEqual(removed, "A")
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)

        removed = list.removeLast()
        XCTAssertNil(removed)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
    }

    func testRemoveFirst() {
        list.append("A")
        list.append("B")
        list.append("C")

        var removed = list.removeFirst()
        XCTAssertEqual(removed, "A")
        XCTAssertEqual(list.first, "B")
        XCTAssertEqual(list.last, "C")

        removed = list.removeFirst()
        XCTAssertEqual(removed, "B")
        XCTAssertEqual(list.first, "C")
        XCTAssertEqual(list.last, "C")

        removed = list.removeFirst()
        XCTAssertEqual(removed, "C")
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)

        removed = list.removeFirst()
        XCTAssertNil(removed)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
    }

    func testClear() {
        list.append("A")
        list.append("B")
        list.append("C")
        list.clear()
        XCTAssert(list.isEmpty)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
    }
}
