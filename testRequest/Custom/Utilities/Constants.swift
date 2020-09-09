//
//  Constants.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import Foundation

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
    static let sadErrorTitle        = "Что-то не так 😔."
    static let noErrorsTitle        = "Успех 🎉."
    static let requsetSavedMessage  = "Ваша заявка была успешно сохранена. Все сохраненные заявки можно найти на вкладке История."
    static let cantOpenWebsite      = "Не удаётся открыть веб-сайт. Возможно, ссылка устарела."
}


struct URLConstants {
    static let order77Table = URL(string: "https://github.com/bcryptoregulatory/skzi-requirements/blob/master/skzi-requirements.md")
}
