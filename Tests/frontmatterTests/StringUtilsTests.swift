import Foundation
@testable import Frontmatter
import Testing

@Test func addingSeparators() {
    let yaml = "some: value\n"
    let withFrontmatter = """
---
some: value
---

"""
    #expect(yaml.addingSeparators == withFrontmatter)
}

@Test func hasFrontmatter() {
    let regular = """
---
some: value
---

Some text
"""

    #expect(regular.hasFrontmatter)

    let noEnd = """
---
some: value
"""

    #expect(!noEnd.hasFrontmatter)

    let noStart = """
some: value
---

Some text
"""

    #expect(!noStart.hasFrontmatter)

    let withNewlines = """


---
some: value
---

This should be ok as well?
"""
    #expect(withNewlines.hasFrontmatter)
}

@Test func replace() {
    let existing = """
---
some: value
---

Here's a blog post and it's allowed to have another separator:
---
Like this
"""

    let replaced = """
---
some: other
---

Here's a blog post and it's allowed to have another separator:
---
Like this
"""
    struct SomeContent: Encodable {
        let some: String
    }

    #expect(existing.withFrontmatter("some: other") == replaced)
}
