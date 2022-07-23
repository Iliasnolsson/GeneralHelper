//
//  File.swift
//  
//
//  Created by Ilias Nikolaidis Olsson on 2022-07-23.
//

import Foundation

public extension String {
    
    /// - Returns: Treats this string as a key for localization, gives back localization value
    var localized: String {
        NSLocalizedString(self, comment: " ")
    }
    
    /// - Returns: Treats this string as a key for localization, gives back localization value in given language
    func localized(inLanguage language: String) -> String? {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle?.localizedString(forKey: "key", value: nil, table: nil)
    }
    
    /// - Returns: Localization for key in current cutlure
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: " ")
    }
    
    /// - Returns: All languages registered localizations
    static func localizationLanugages() -> [String] {
        return Bundle.main.localizations
    }
    
    /// - Returns: Dictionary where key is key of localization & value is the localization
    static func localizations(forLanguage language: String) -> [String : String]? {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        if let stringsFilePath = bundle?.paths(forResourcesOfType: "strings", inDirectory: nil).first {
            if let dictionary = NSDictionary(contentsOfFile: stringsFilePath) {
                var dict = [String : String]()
                for (key, value) in dictionary {
                    if let key = key as? String, let value = value as? String {
                        dict[key] = value
                    }
                }
                return dict
            }
        }
        return [:]
    }

    /// - Returns: Alll keys of all localizations
    static func localizationKeys() -> [String] {
        var keys = [String]()
        for language in localizationLanugages() {
            if let localizationDict = localizations(forLanguage: language) {
                for (key, _) in localizationDict {
                    keys.append(key)
                }
            }
        }
        return Array(Set(keys)).sorted()
    }
    
    /// Prints all localizations for language as json, usefull for moving localization to other languages, like javascript & typescript
    static func printLocalizationsJson(forLanguage language: String) {
        if let localizationDict = localizations(forLanguage: language) {
            print("")
            print(language + ":")
            if localizationDict.isEmpty {
                print("Empty")
            }
            print("{")
            var index = 0
            let lastIndex = localizationDict.count - 1
            for (key, value) in localizationDict.sorted(by: {$0.key > $1.key}) {
                print("  \"" + key + "\": " + "\"" + value + "\"" + (index != lastIndex ? "," : ""))
                index += 1
            }
            print("}")
        }
    }
    
    /// Prints all localizations as json, usefull for moving localization to other languages, like javascript & typescript
    static func printLocalizationsJson() {
        print("")
        print("")
        for language in Bundle.main.localizations {
            printLocalizationsJson(forLanguage: language)
        }
        print("")
        print("")
    }
    
    /// Prints a class for easier access to localizations
    static func printLocalizationsSwift() {
        print("")
        print("")
        print("class Localizations {")
        for key in localizationKeys() {
            let keySafe = key.isSyntax ? "`" + key + "`" : key
            print("    static var \(keySafe): String {get {\"\(key)\".localized}}")
        }
        print("}")
    }
    
    /// Prints a class for easier access to localizations in javascript & typescript
    static func printLocalizationsJavascript() {
        print("")
        print("")
        print("// ------ in main.ts ------")
        print("// const { t } = i18n.global")
        print("// export function localize(key: string) : string {")
        print("// return t(key)")
        print("// }")
        print("")
        print("import { localize } from \"@/main\"")
        print("")
        print("export class Localizations {")
        for key in localizationKeys() {
            let value = "\"" + key + "\""
            let key = key.isJavascriptSyntax ? key + "Localization" : key
            print("    static get " + key + "() {return localize(\(value))}")
        }
        print("}")
    }
    
    static var swiftSyntax = [
        "return",
        "in",
        "do",
        "continue",
        "is",
        "case",
        "func",
        "enum",
        "class",
        "switch"]
    
    static var javascriptSyntax = [
        "name"]
    
    
    var isSyntax: Bool {
        return String.swiftSyntax.contains(self)
    }
    
    var isJavascriptSyntax: Bool {
        return String.javascriptSyntax.contains(self)
    }

}
