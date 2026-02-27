import Foundation

extension URL {
    /// Default localhost URL for development
    public static var home: URL {
        // Safe: "http://localhost:8080" is always a valid URL
        URL(string: "http://localhost:8080")!
    }

    /// Placeholder URL for cases where a URL is required but not available
    /// Use this instead of force-unwrapping empty strings
    public static var placeholder: URL {
        // Safe: "about:blank" is always a valid URL
        URL(string: "about:blank")!
    }

    /// Returns nil instead of crashing for empty/invalid URL scenarios
    public static func safeURL(from string: String) -> URL? {
        guard !string.isEmpty else { return nil }
        return URL(string: string)
    }
}
