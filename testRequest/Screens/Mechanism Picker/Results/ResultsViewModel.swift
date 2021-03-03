//
//  ResultsViewModel.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 26.02.21.
//

import UIKit

struct ResultsViewModel {

    let request: Request

    // MARK: Table View

    var requestHasUnusedMechanisms: Bool {
        return !unusedMechanisms.isEmpty
    }

    let numberOfSections = 7

    func numberOfRows(in section: Int) -> Int {
        sectionSizes[section]
    }

    func titleForHeader(in section: Int) -> String {
        return "\(16 + section). \(sectionHeaders[section])"
    }

    private let sectionSizes = [2, 4, 2, 1, 1, 1, 3]

    private let sectionHeaders = ["Предварительное шифрование",
                                "Линейное шифрование",
                                "Выработка ЭЦП",
                                "Криптографический токен",
                                "Проверка ЭЦП",
                                "Выработка ключей",
                                "Контроль целостности"]

    // MARK: _

    var unusedMechanisms: [Mechanism] {
        var unusedMechanisms = request.declaredMechanisms

        for paragraph in matchingParagraphs {
            for mechanismsBlock in paragraph.demandedMechanisms {
                for mechanism in mechanismsBlock {
                    if let mechanismIndex = unusedMechanisms.firstIndex(of: mechanism) {
                        unusedMechanisms.remove(at: mechanismIndex)
                    }
                }
            }
        }
        return unusedMechanisms
    }

    var unusedMechanismsShort: String {
        "\(unusedMechanisms.reduce("", { $0 + " " + $1.shortName + "," }).dropLast())"
    }

    // MARK: Public functions

    func paragraphAccessoryInfo(for indexPath: IndexPath) -> (String, String) {
        let paragraph = getParagraph(for: indexPath)
        let title = "Примечание к пункту \(paragraph.shortName)"
        let message = paragraph.rawValue
        return (title, message)
    }

    func paragraphCellInfo(for indexPath: IndexPath) -> (String, String?, UIColor) {

        let paragraph = getParagraph(for: indexPath)
        let baseTitle = "\(indexPath.row + 1). "

        if let missingMechanisms = missingMechanisms(for: paragraph) {
            let details = missingMechanisms.reduce("Добавьте", { $0 + " " + $1.shortName + " или" }).dropLast(4)
            return (baseTitle + "Не соответствует", String(details), TRColors.failure)

        } else {
            return (baseTitle + "Соответствует", nil, TRColors.success)
        }
    }

    // MARK: Private

    private var matchingParagraphs: [Paragraph] {
        Paragraph.allCases.filter { missingMechanisms(for: $0) == nil } // matchingParagraphs.sorted { $0.shortName < $1.shortName }
    }

    private func getParagraph(for indexPath: IndexPath) -> Paragraph {
        let shortNameForIndexPath = "\(indexPath.section + 16).\(indexPath.row + 1)"
        guard let paragraph = Paragraph.allCases.filter({ $0.shortName == shortNameForIndexPath }).first else {
            fatalError(TRErrorVerbouseConstants.paragraphError)
        }

        return paragraph
    }

    private func missingMechanisms(for paragraph: Paragraph) -> [Mechanism]? {

        for mechanismsBlock in paragraph.demandedMechanisms {
            if !request.contains(anyOf: mechanismsBlock) {
                return mechanismsBlock // FIX: mechanisms += mechanismsBlock
            }
        }

        return nil
    }
}
