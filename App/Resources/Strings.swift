// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation
import SwiftUI

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// GameHub
  public static var appName: String { Strings.tr("Localizable", "app_name") }
  /// Cancel
  public static var cancel: String { Strings.tr("Localizable", "cancel") }
  /// Discover Your Next Favorite Game
  public static var discoverYourNextFavoriteGame: String { Strings.tr("Localizable", "discover_your_next_favorite_game") }
  /// Don't give up! The next game is here.
  public static var doNotGiveUpTheNextGameIsHere: String { Strings.tr("Localizable", "do_not_give_up_the_next_game_is_here") }
  /// Done
  public static var done: String { Strings.tr("Localizable", "done") }
  /// Favorites
  public static var favorites: String { Strings.tr("Localizable", "favorites") }
  /// Find Next Game
  public static var findNextGame: String { Strings.tr("Localizable", "find_next_game") }
  /// Games
  public static var games: String { Strings.tr("Localizable", "games") }
  /// No internet connection!
  public static var noInternetConnection: String { Strings.tr("Localizable", "no_internet_connection") }
  /// This field is required
  public static var `required`: String { Strings.tr("Localizable", "required") }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: AppLanguage.locale, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
