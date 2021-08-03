//
//  NasaItems.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import Foundation



struct NasaResponse: Codable {
    public var collection: NasaCollection
}

struct NasaCollection: Codable {
    public var version: String?
    public var items: [NasaItems]
    public var href: String?
}

struct NasaItems: Codable{
    public var links: [LinksImage]?
    public var href: String
    public var data: [DataNasa]?
}

struct LinksImage: Codable {
    public var rel: String
    public var href: String
    public var render: String?
}

struct DataNasa: Codable {
    public var secondary_creator: String?
    public var media_type: String?
    public var description: String?
    public var date_created: String?
    public var description_508v: String?
    public var title: String?
    public var keywords: [String]?
    public var center: String?
    public var nasa_id: String
}
