import Foundation
import Yams

extension String {
    static let separator = "---\n"

    static func from<T: Encodable>(_ value: T) throws (Frontmatter.Error) -> String {
        do {
            return try YAMLEncoder().encode(value)
        } catch {
            throw .encoding(error)
        }
    }

    static func readFile(_ path: String) throws (Frontmatter.Error) -> String {
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            throw .invalidPath(path: path, error)
        }
    }

    func write(to path: String) throws (Frontmatter.Error) {
        do {
            try write(
                to: URL(filePath: path),
                atomically: true,
                encoding: .utf8
            )
        } catch {
            throw .write(path: path, error)
        }
    }

    func withFrontmatter(_ yamlString: String) -> String {
        if hasFrontmatter {
            replacingFrontmatter(with: yamlString)
        } else {
            yamlString.addingSeparators + "\n" + self
        }
    }

    func replacingFrontmatter(with yamlString: String) -> String {
        let parts = split(separator: String.separator)
        let existingContent = parts.dropFirst().joined(separator: .separator)

        return yamlString.addingSeparators + existingContent
    }

    var hasFrontmatter: Bool {
        let array = split(separator: String.separator)
        return array.count >= 2 && trimmingCharacters(in: .newlines).hasPrefix(.separator)
    }

    var addingSeparators: String {
        .separator + addingLinebreakSuffixIfNeeded + .separator
    }

    var addingLinebreakSuffixIfNeeded: String {
        hasSuffix("\n")
            ? self
            : self + "\n"
    }
}

