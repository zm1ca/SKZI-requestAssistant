//
//  Constants.swift
//  SKZI-requestAssistant
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


struct ParagraphDetails {
    static let p16_1 = "Для СКЗИ применяющих предварительное распределение ключей."
    static let p16_2 = "Для СКЗИ в которых доверие к ключам шифрования устанавливается посредством ЭЦП."
    static let p17_1 = "Для линейных шифраторов с предварительным распределением секретов."
    static let p17_2 = "Для линейных шифраторов с протоколом Диффи-Хеллмана усиленным ЭЦП."
    static let p17_3 = "Для линейных шифраторов реализующих протокол TLS."
    static let p17_4 = "Для линейных шифраторов применяющих альтернативное усиление протокола Диффи-Хеллмана."
    static let p18_1 = "Для программных средств выработки ЭЦП."
    static let p18_2 = "Для аппаратных средств выработки ЭЦП."
    static let p19_1 = "Для защищённого аппаратного хранилища личного ключа."
    static let p20_1 = "Для СКЗИ осуществляющих проверку ЭЦП."
    static let p21_1 = "Для СКЗИ осуществляющих выработку личных и открытых ключей ЭЦП."
    static let p22_1 = "Для контроля целостности с помощью бесключевых хэш-функций."
    static let p22_2 = "Для контроля целостности с помощью ключевых хэш-функций"
    static let p22_3 = "Для контроля целостности с помощью ЭЦП."
}


struct TRAlertConstants {
    static let somethingWrong       = "Что-то пошло не так ☹️"
    static let paragraphInfo        = "Примечание к пункту"
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
