//
//  SettingsModel.swift
//  VoiceBite
//

import Foundation
import Combine

class AppSettingsModel: ObservableObject {
    @Published var isDarkMode: Bool

    init(isDarkMode: Bool) {
        self.isDarkMode = isDarkMode
    }
}
