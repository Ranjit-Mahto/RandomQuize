//
//  Constant.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 17/02/24.
//

enum Constant {
    enum API {
        static let queryURL = "https://run.mocky.io/v3/8787374e-76f5-4506-bcf1-506720e2e04d"
    }
}

enum EventStatus {
    case startLoading
    case stopLoading
    case dataLoaded
    case error(Error?)
}
