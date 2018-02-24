//
//  Reporter.swift
//  Demo
//
//  Created by Sam Meech-Ward on 2017-03-09.
//
//

import Foundation
import Observe
import Focus

enum ANSI {
    case escapeCode
    
    func escape() -> String {
        return ANSI.escapeCode.caseString()+self.caseString()
    }
    
    func console() {
        let string = self.escape()
        print(string, terminator: "")
    }
    
    case clearLine
    case clearScreen
    case moveCursorBack(times: Int)
    case moveCursorUp(times: Int)
    
    // MARK: Colors
    case green
    case white
    case red
    
    private func caseString() -> String {
        switch self {
        case .escapeCode: return "\u{001B}["
        case .clearLine: return "0J"
        case .clearScreen: return "2J"
        case let .moveCursorBack(times): return "\(times)D"
        case let .moveCursorUp(times): return "\(times)A"
        case .green: return "32m"
        case .white: return "37m"
        case .red: return "31m"
        }
    }
}

public class Reporter {
    
    public var lastIndentationLevel = 0
    public var totalTestsPassed = 0
    public var totalTestsFailed = 0
    
    public var failBlock: ((_ message: String, _ file: StaticString, _ line: UInt) -> Void)?
    
    public static let sharedInstance = Reporter()
    
}

// MARK: Print
extension Reporter {
    func printText(_ text: String) {
        deleteLastTotalTests()
        print(text)
        printTotalTests()
    }
    
    func printTest(_ text: String) {
        ANSI.white.console()
        printText(text)
    }
    
    func printPass(_ text: String) {
        ANSI.green.console()
        printText(text)
    }
    
    func printFail(_ text: String) {
        ANSI.red.console()
        printText(text)
    }
    
    func printWithIndentation(file: StaticString, method: String, line: UInt, message: String, blockType: String, indentationLevel: Int) {
        if indentationLevel == 0 {
            print("")
            printTest("\nFile: \(file), Method: \(method)")
        }
        
        var printMessage = ""
        
        for _ in 0...indentationLevel {
            printMessage += "--"
        }
        
        printMessage += "| \(blockType)): "
        
        printMessage += message
        
        printTest(printMessage)
    }
    
    func printTotalTests() {
        print("")
        
        let passedString = "Passed: \(totalTestsPassed)"
        let failedString = "Failed: \(totalTestsFailed)"
        let seperatorString = ", "
        
        ANSI.green.console()
        print(passedString, terminator: "")
        
        ANSI.white.console()
        print(seperatorString, terminator: "")
        
        ANSI.red.console()
        print(failedString, terminator: "")
        
        ANSI.white.console()
        print("")
        print("")
    }
    
    func deleteLastTotalTests() {
        ANSI.clearLine.console()
        ANSI.moveCursorUp(times: 1).console()
        ANSI.clearLine.console()
        ANSI.moveCursorUp(times: 1).console()
        ANSI.clearLine.console()
        ANSI.moveCursorUp(times: 1).console()
        ANSI.clearLine.console()
    }
}

extension Reporter: Observe.Reportable {
    public func willRunBlock(file: StaticString, method: String, line: UInt, message: String, blockType: BlockType, indentationLevel: Int) {
        printWithIndentation(file: file, method: method, line: line, message: message, blockType: blockTypeString(blockType: blockType), indentationLevel: indentationLevel)
        lastIndentationLevel = indentationLevel
    }
    
    public func didRunBlock(file: StaticString, method: String, line: UInt, message: String, blockType: BlockType, indentationLevel: Int) {
        
    }
    
    private func blockTypeString(blockType: BlockType) -> String {
        switch blockType {
        case .given:
            return "Given"
        case .when:
            return "When"
        case .then:
            return "Then"
        case .and:
            return "And"
        default:
            return ""
        }
    }
}

extension Reporter: Focus.Reportable {
    public func testPassed(file: StaticString, method: String, line: UInt, message: String, evaluation: String) {
        totalTestsPassed+=1
        var printMessage = "  "
        
        for _ in 0...lastIndentationLevel {
            printMessage += "  "
        }
        
        printMessage += "👍"
        
        printPass(printMessage)
    }
    
    public func testFailed(file: StaticString, method: String, line: UInt, message: String, evaluation: String) {
        totalTestsFailed+=1
        var printMessage = "  "
        
        for _ in 0...lastIndentationLevel {
            printMessage += "  "
        }
        
        printMessage += "👎  \(message), \(evaluation). File: \(file), Method: \(method), Line:\(line)"
        
        printFail(printMessage)
        
        if let failBlock = failBlock {
            failBlock(message, file, line)
        }
    }
}
