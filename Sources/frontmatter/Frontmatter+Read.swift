import Foundation
import Yams

public enum Frontmatter {}

public extension Frontmatter {
    static func decode<T: Decodable>(
        _ type: T.Type = T.self,
        file path: String
    ) throws (Error) -> T {
        try decode(contents: .readFile(path))
    }

    static func decode<T: Decodable>(
        _ type: T.Type = T.self,
        data: Data
    ) throws (Error) -> T {
        guard let contents = String(data: data, encoding: .utf8),
              !contents.isEmpty else {
            throw .invalidData
        }

        return try decode(contents: contents)
    }

    static func decode<T: Decodable>(
        _ type: T.Type = T.self,
        contents: String
    ) throws (Error) -> T {
        let array = contents.split(separator: String.separator)
        guard contents.hasFrontmatter, array.count >= 2 else {
            throw .invalidFormat(contents)
        }

        let frontmatter = String(array[0])
        do {
            return try YAMLDecoder().decode(T.self, from: frontmatter)
        } catch {
            throw .decoding(error)
        }
    }
}
