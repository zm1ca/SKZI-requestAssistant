//
//  SavedRequestsViewModel.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.03.21.
//

import Foundation

protocol RequestPresentable {
    var title: String { get }
    var paragraphs: String { get }
    var dateModified: String { get }
}

struct SavedRequestsViewModel: RequestPresentable {

    let request: Request

    var title: String {
        "\(request.productName) от «\(request.organizationName)»"
    }

    var paragraphs: String {
        // TODO: Usage of ResultsViewModel seems to be a totally wrong decision

        let resultsViewModel = ResultsViewModel(request: request)
        let matchingParagraphs = resultsViewModel.matchingParagraphs

        if matchingParagraphs.isEmpty {
            return "Не соответствует приказу №77 ОАЦ."
        } else {
            let matchingParagraphs = matchingParagraphs.reduce("Соответствует:", { $0 + " " + $1.shortName + "," })
            return String(matchingParagraphs.dropLast())
        }
    }

    var dateModified: String {
        let dateFormatter        = DateFormatter()
        dateFormatter.locale     = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"

        return dateFormatter.string(from: request.dateModified)
    }
}
