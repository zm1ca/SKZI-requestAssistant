//
//  Constants.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import UIKit

struct ResultsTableViewConstants {
    static let numberOfSections = 7
    static let sectionSizes     = [2, 4, 2, 1, 1, 1, 3]
    static let sectionHeaders   = ["Предварительное шифрование",
                                   "Линейное шифрование",
                                   "Выработка ЭЦП",
                                   "Криптографический токен",
                                   "Проверка ЭЦП",
                                   "Выработка ключей",
                                   "Контроль целостности"]
}


struct TRAlertConstants {
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
