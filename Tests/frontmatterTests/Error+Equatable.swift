import Foundation
import Frontmatter

extension Frontmatter.Error: Equatable {
    public static func ==(lhs: Frontmatter.Error, rhs: Frontmatter.Error) -> Bool {
        switch (lhs, rhs) {
        case (.invalidData, .invalidData):
            true
        case let (.invalidFormat(lhsString), .invalidFormat(rhsString)):
            lhsString == rhsString
        case let (.decoding(lhsError), .decoding(rhsError)):
            String(describing: lhsError) == String(describing: rhsError)
        case let (.invalidPath(lhsPath, lhsError), .invalidPath(rhsPath, rhsError)):
            lhsPath == rhsPath && lhsError.localizedDescription == rhsError.localizedDescription
        case (.encoding, .encoding):
            true
        case let (.write(lhsPath, _), .write(rhsPath, _)):
            lhsPath == rhsPath
        default:
            false
        }
    }
}

