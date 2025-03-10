[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSwiftToolkit%2Ffrontmatter%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/SwiftToolkit/frontmatter)

# Frontmatter

A Swift package for parsing YAML frontmatter from files, providing a simple and type-safe way to extract and decode frontmatter metadata.

This package is a wrapper around [Yams](https://github.com/jpsim/Yams), providing a convenient API specifically for frontmatter parsing and encoding.

## Installation

Add the following to your `Package.swift` package dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/swifttoolkit/frontmatter.git", from: "1.0.0")
]
```

Then add Frontmatter to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: .product(name: "Frontmatter", package: "frontmatter")
    )
]
```

## Usage

### Reading

The package provides several ways to decode frontmatter:

#### From a file:

```swift
struct Metadata: Codable {
    let title: String
    let date: String
    let tags: [String]
}

let metadata = try Frontmatter.decode(Metadata.self, file: "path/to/file.md")
```

#### From a string:

```swift
let contents = """
---
title: My Post
date: 2024-03-20
tags: ["swift", "coding"]
---

Post content here...
"""

let metadata = try Frontmatter.decode(Metadata.self, contents: contents)
```

#### From Data:
```swift
let data = try Data(contentsOf: myFileURL)
let metadata = try Frontmatter.decode(Metadata.self, data: data)
```

### Writing

You can also encode any `Decodable` type, and set it as the frontmatter for a file or a string. When encoding to an existing file or string that already has frontmatter, the package will automatically replace the existing frontmatter while preserving the rest of the content.

```swift
let metadata = Metadata(
    title: "My Post",
    date: "2025-03-20",
    tags: ["swift", "coding"]
)
try Frontmatter.encode(metadata, to: "path/to/file.md")
```

The encode methods return a `WriteResult` indicating what happened:
- `.created`: A new file was created
- `.added`: Frontmatter was added to an existing file without frontmatter
- `.updated`: Existing frontmatter was updated in the file

Alternatively, you can use the `encode` method to encode and get a string:

```swift
let initialContents = "Some initial content"
let updatedContents = try Frontmatter.encode(metadata, contents: initialContents)
```

The code above will return the following string:

```
---
title: My Post
date: '2025-03-20'
tags:
- swift
- coding
---

Some initial content
```

## Format

The frontmatter should be:
- Enclosed between `---` separators
- At the beginning of the file
- Valid YAML format

Example:
```markdown
---
title: My Post
date: 2024-03-20
tags: ["swift", "coding"]
---

A post content here...
```

## Requirements

- Swift 6.0+
