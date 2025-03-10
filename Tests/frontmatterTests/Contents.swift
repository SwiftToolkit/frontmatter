import Foundation

let sampleContent = Content(
    language: "typescript",
    mode: "strict",
    ready: false,
    sampleFiles: 6
)

struct Content: Codable, Equatable {
    let language: String
    let mode: String
    let ready: Bool
    let sampleFiles: Int

    enum CodingKeys: String, CodingKey {
        case language
        case mode
        case ready
        case sampleFiles
    }
}

let sampleContentYaml = """
language: typescript
mode: strict
ready: false
sampleFiles: 6
"""

let sampleContentFrontmatter = """
---
\(sampleContentYaml)
---

"""

let validContentString = """
---
\(sampleContentYaml)
---

This is an example blog post!
And another acceptable divider here:
---
"""

let invalidContentString = """
\(sampleContentYaml)
---

This is should fail, as there's no starting divider
"""

let missingLanguage = """
---
mode: strict
ready: false
sampleFiles: 6
---

This is should fail, as there's no starting divider
"""
