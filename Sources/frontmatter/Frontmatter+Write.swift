import Foundation
import Yams

/// When encoding a frontmatter content into a file, one a `WriteResult` is returned
public enum WriteResult {
    /// A new file was created
    case created

    /// The file existed, and frontmatter was added
    case added

    /// The file existed with frontmatter, and it was updated
    case updated
}

public extension Frontmatter {
    @discardableResult
    static func encode<T: Encodable>(
        _ value: T,
        to url: URL
    ) throws (Error) -> WriteResult {
        try encode(value, to: url.path())
    }

    @discardableResult
    static func encode<T: Encodable>(
        _ value: T,
        to path: String
    ) throws (Error) -> WriteResult {
        try persist(yamlString: .from(value), to: path)
    }

    @discardableResult
    static func encode<T: Encodable>(
        _ value: T,
        contents: String = ""
    ) throws (Error) -> String {
        try contents.withFrontmatter(.from(value))
    }

    private static func persist(
        yamlString: String,
        to path: String
    ) throws (Error) -> WriteResult {
        if FileManager.default.fileExists(atPath: path) {
            try updateFile(yamlString: yamlString, to: path)
        } else {
            try writeNewFile(yamlString: yamlString, to: path)
        }
    }

    private static func updateFile(
        yamlString: String,
        to path: String
    ) throws (Error) -> WriteResult {
        let contents = try String.readFile(path)
        let withFrontmatter = contents.withFrontmatter(yamlString)
        try withFrontmatter.write(to: path)

        return contents.hasFrontmatter
            ? .updated
            : .added
    }

    private static func writeNewFile(
        yamlString: String,
        to path: String
    ) throws (Error) -> WriteResult {
        try yamlString.addingSeparators.write(to: path)
        return .created
    }
}
