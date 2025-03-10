import Foundation
@testable import Frontmatter
import Testing

@Test func testEncodeToPath() throws {
    let path = FileManager.default.temporaryDirectory.appending(path: "\(UUID()).md").path()
    let result = try Frontmatter.encode(sampleContent, to: path)
    let content = try String.readFile(path)
    #expect(content == sampleContentFrontmatter)
    #expect(result == .created)
}

@Test func testEncodeToURL() throws {
    let url = FileManager.default.temporaryDirectory.appending(path: "\(UUID()).md")
    let result = try Frontmatter.encode(sampleContent, to: url)
    let content = try String.readFile(url.path())
    #expect(content == sampleContentFrontmatter)
    #expect(result == .created)
}

@Test func testEncodeAddingFrontmatter() throws {
    let path = FileManager.default.temporaryDirectory.appending(path: "\(UUID()).md").path()
    let initialText = "Some Text"
    try initialText.write(to: path)
    let result = try Frontmatter.encode(sampleContent, to: path)
    let content = try String.readFile(path)
    let expectedValue = """
---
\(sampleContentYaml)
---

\(initialText)
"""
    #expect(content == expectedValue)
    #expect(result == .added)
}

@Test func testEncodeReplacingFrontmatter() throws {
    let path = FileManager.default.temporaryDirectory.appending(path: "\(UUID()).md").path()
    let initialYaml = "some: value"
    let text = "Some text after frontmatter"
    let initialContent = """
    ---
    \(initialYaml)
    ---
    
    \(text)
    """

    try initialContent.write(to: path)
    let result = try Frontmatter.encode(sampleContent, to: path)
    let content = try String.readFile(path)
    let expectedValue = """
---
\(sampleContentYaml)
---

\(text)
"""
    #expect(content == expectedValue)
    #expect(result == .updated)
}

@Test func encodingToString() throws {
    let initialYaml = "some: value"
    let text = "Some text after frontmatter"
    let initialContent = """
    ---
    \(initialYaml)
    ---
    
    \(text)
    """

    let expectedValue = """
---
\(sampleContentYaml)
---

\(text)
"""

    #expect(try Frontmatter.encode(sampleContent, contents: initialContent) == expectedValue)
}

@Test func encodingWithoutString() throws {
    let expectedValue = """
    ---
    \(sampleContentYaml)
    ---


    """

    let encoded = try Frontmatter.encode(sampleContent)
    #expect(encoded == expectedValue)
}

@Test func encodingWithString() throws {
    let initialContent = "I was here before"
    let expectedValue = """
    ---
    \(sampleContentYaml)
    ---

    \(initialContent)
    """

    let encoded = try Frontmatter.encode(sampleContent, contents: initialContent)
    #expect(encoded == expectedValue)
}
