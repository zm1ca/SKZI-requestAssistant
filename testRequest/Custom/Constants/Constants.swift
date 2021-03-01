//
//  Constants.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import UIKit


struct TRErrorVerbouseConstants {
    static let somethingWrong       = "Что-то пошло не так ☹️"
    static let cantOpenWebsite      = "Не удаётся открыть веб-сайт. Возможно, ссылка устарела."
    static let paragraphError       = "Ошибка при распознавании пунктов приказа."
}


struct URLConstants {
    static let order77Table = URL(string: "https://github.com/bcryptoregulatory/skzi-requirements/blob/master/skzi-requirements.md")
}


struct TRColors {
    static let success = UIColor.systemGreen.withAlphaComponent(0.5)
    static let failure = UIColor.systemRed.withAlphaComponent(0.5)
}
