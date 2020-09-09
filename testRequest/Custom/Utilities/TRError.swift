//
//  TRError.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

enum TRError: String, Error {
    case unableToSave = "Не удалось сохранить заявку."
    case alreadySaved = "В точности такая заявка уже сохранена."
}
