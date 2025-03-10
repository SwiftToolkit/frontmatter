import Foundation

public extension Frontmatter {
    enum Error: Swift.Error {
        // When the provided file path is not a valid string
        case invalidPath(path: String, Swift.Error)

        // When the contents do not have the opening and closing `---` separators
        case invalidFormat(String)

        // When the provided Data can't be converted to a valid string
        case invalidData

        // The data provided was valid, but an error decoding the yaml
        // contents happened
        case decoding(Swift.Error)

        // When encoding to YAML fails
        case encoding(Swift.Error)

        // When saving a file with frontmatter content fails
        case write(path: String, Swift.Error)
    }
}

extension Frontmatter.Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .invalidPath(path, error):
            "The file provided at \(path) is invalid: \(error)"
        case let .invalidFormat(string):
            "The following string does not contain the minimum count of 2 `---` separators:\n\(string)"
        case .invalidData:
            "The provided data could not be converted to a non-empty string"
        case let .decoding(error):
            "Error decoding from YAML: \(error)"
        case let .encoding(error):
            "Error encoding to YAML: \(error)"
        case let .write(path, error):
            "Error writing to file \(path): \(error)"
        }
    }
}
