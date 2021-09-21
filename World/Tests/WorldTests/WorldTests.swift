import XCTest
@testable import World

final class WorldTests: XCTestCase {
    func testPreferredLocale() {
        print(World.preferredLocale(language: "en", region: "US"))
        print(World.preferredLocale(language: "no", region: "NO"))
        print(World.preferredLocale(language: "nb", region: "NO"))
        print(World.preferredLocale(language: "en", region: "NO"))
        print(World.preferredLocale(language: "en", region: "CN"))
        print(World.preferredLocale(language: "zh", region: "CN"))
        print(World.preferredLocale(language: "en", region: "HK"))
        print(World.preferredLocale(language: "zh", region: "HK"))
    }

    func testFlags() {
        print(World.flag(for: "CN"))
        print(World.flag(for: "US"))
        print(World.flag(for: "NO"))
    }

    func testCurrencies() {
        var preferred = false
        print(World.isCurrency("NOK", usedIn: "NO", preferred: &preferred), preferred ? "preferred" : "")
        print(World.isCurrency("USD", usedIn: "SV", preferred: &preferred), preferred ? "preferred" : "")
    }
}
