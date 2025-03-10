import Foundation
@testable import Frontmatter
import Testing

@Test func invalidData() throws {
    #expect(throws: Frontmatter.Error.invalidData) {
        try Frontmatter.decode(Content.self, data: Data())
    }
}

@Test func invalidFormat() throws {
    #expect(throws: Frontmatter.Error.invalidFormat(invalidContentString)) {
        try Frontmatter.decode(Content.self, contents: invalidContentString)
    }
}

@Test func decodingError() throws {
    let decodingError = DecodingError.keyNotFound(
        Content.CodingKeys.language,
        DecodingError.Context(
            codingPath: [],
            debugDescription: "No value associated with key \(Content.CodingKeys.language) (\"language\")."
        )
    )

    #expect(throws: Frontmatter.Error.decoding(decodingError)) {
        try Frontmatter.decode(Content.self, contents: missingLanguage)
    }
}

@Test func fromString() throws {
    let decoded: Content = try Frontmatter.decode(contents: validContentString)
    #expect(decoded == sampleContent)
}

@Test func validFromFile() throws {
    let tempFileURL = FileManager.default.temporaryDirectory.appending(path: "\(UUID()).md")
    try validContentString.write(to: tempFileURL, atomically: true, encoding: .utf8)
    let filePath = tempFileURL.path()
    let decoded = try Frontmatter.decode(Content.self, file: filePath)
    #expect(decoded == sampleContent)
}

@Test func invalidFromFile() throws {
    let tempFile = FileManager.default.temporaryDirectory.appending(path: "\(UUID()).md")
    let filePath = tempFile.path()
    do {
        _ = try Data(contentsOf: tempFile)
    } catch {
        #expect(throws: Frontmatter.Error.invalidPath(path: filePath, error)) {
            try Frontmatter.decode(Content.self, file: filePath)
        }
    }
}

@Test func fromData() throws {
    let data = validContentString.data(using: .utf8)!
    let decoded = try Frontmatter.decode(Content.self, data: data)
    #expect(decoded == sampleContent)
}
