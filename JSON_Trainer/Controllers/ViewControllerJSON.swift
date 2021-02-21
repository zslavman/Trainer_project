//
//  ViewControllerJSON.swift
//  JSON_Trainer
//
//  Created by Zinko Viacheslav on 08.04.2020.
//  Copyright © 2020 Zinko Viacheslav. All rights reserved.
//

import UIKit

extension ViewController {
    
    internal func run1() {
        guard let path = Bundle.main.path(forResource: "index", ofType: "json") else { return }
        do {
            let jsonData = try String(contentsOfFile: path).data(using: .utf8)!
            let parsedData = try JSONDecoder().decode(InstructionsFromJSON.self, from: jsonData)
            self.parsed = parsedData.purchaseItems
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
}

//MARK: - JSON Model
///*********************************************


struct InstructionsFromJSON: Decodable {
    let filterConfig : FilterConfig!
    let purchaseItems: [PurchModel]
}


struct FilterConfig: Decodable {
    let types       : [String : Any]
    let specialists : [String : Any]
    let targets     : [String : Any]
    
    enum CodingKeys: String, CodingKey {
        case types
        case specialists
        case targets
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        types       = try container.decode([String: Any].self, forKey: .types)
        specialists = try container.decode([String: Any].self, forKey: .specialists)
        targets     = try container.decode([String: Any].self, forKey: .targets)
    }
}


struct ShopFilter {
    let types: [Int]
    let specialists: [Int]
    let targets: [Int]
    
    //    enum CodingKeys: String, CodingKey {
    //        case specialists
    //        case targets
    //        case types
    //    }
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        types = try values.decode([Int].self, forKey: .types)
    //        specialists = try values.decode([Int].self, forKey: .specialists)
    //        targets = try values.decode([Int].self, forKey: .targets)
    //    }
}


struct PurchModel: Decodable {
    var diffId: Int {
        return purchaseID.hashValue &* 16777619
    }
    
    let title            : [String: Any]
    let descript_short    : [String: Any]
    let descript_long    : [String: Any]
    let purchaseID      : String
    let type            : String
    let cardsCount        : UInt
    let order            : UInt
    let mainImgURL_small: String
    let imageURL_1        : String
    let imageURL_2        : String
    let imageURL_3        : String
    let reserved1       : String
    let reserved2       : String
    var shopFilter      : ShopFilter!
    
    enum CodingKeys: String, CodingKey {
        case title
        case descript_short
        case descript_long
        case purchaseID
        case type
        case cardsCount
        case order
        case mainImgURL_small
        case imageURL_1
        case imageURL_2
        case imageURL_3
        case reserved1
        case reserved2
        case shopFilter
        
        enum Trix: String, CodingKey {
            case types
            case specialists
            case targets
        }
    }
    
    let noTranslation = "[нет перевода]"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title            = try container.decode([String: Any].self, forKey: .title)
        descript_short   = try container.decode([String: Any].self, forKey: .descript_short)
        descript_long    = try container.decode([String: Any].self, forKey: .descript_long)
        purchaseID       = try container.decode(String.self, forKey: .purchaseID)
        type             = try container.decode(String.self, forKey: .type)
        cardsCount       = try container.decode(UInt.self, forKey: .cardsCount)
        order            = try container.decode(UInt.self, forKey: .order)
        mainImgURL_small = try container.decode(String.self, forKey: .mainImgURL_small)
        imageURL_1       = try container.decode(String.self, forKey: .imageURL_1)
        imageURL_2       = try container.decode(String.self, forKey: .imageURL_2)
        imageURL_3       = try container.decode(String.self, forKey: .imageURL_3)
        reserved1        = try container.decode(String.self, forKey: .reserved1)
        reserved2        = try container.decode(String.self, forKey: .reserved2)
        //shopFilter     = try container.decode(ShopFilter.self, forKey: .shopFilter)
        //shopFilter     = try ShopFilter(from: decoder)
        //        let nestCont     = try container.nestedContainer(keyedBy: CodingKeys.Trix.self, forKey: .shopFilter)
        //        let s1      = try nestCont.decode([Int].self, forKey: .types)
        //        let s2      = try nestCont.decode([Int].self, forKey: .specialists)
        //        let s3      = try nestCont.decode([Int].self, forKey: .targets)
        shopFilter  = ShopFilter(types: [], specialists: [], targets: [])
    }
    
    public func getLocalizedFor(source: [String: Any]) -> String {
        if let needProp = source["ru"] as? String {
            return needProp
        }
        return (source["ru"] as? String) ?? noTranslation
    }
}



extension PurchModel: Equatable { }
internal func == (lhs: PurchModel, rhs: PurchModel) -> Bool {
    guard lhs.purchaseID == rhs.purchaseID else { return false }
    guard lhs.type == rhs.type else { return false }
    guard lhs.cardsCount == rhs.cardsCount else { return false }
    guard lhs.order == rhs.order else { return false }
    guard lhs.mainImgURL_small == rhs.mainImgURL_small else { return false }
    guard lhs.imageURL_1 == rhs.imageURL_1 else { return false }
    guard lhs.imageURL_2 == rhs.imageURL_2 else { return false }
    guard lhs.imageURL_3 == rhs.imageURL_3 else { return false }
    guard lhs.reserved1 == rhs.reserved1 else { return false }
    guard lhs.reserved2 == rhs.reserved2 else { return false }
    guard lhs.shopFilter == rhs.shopFilter else { return false }
    return true
}

extension ShopFilter: Equatable { }
internal func == (lhs: ShopFilter, rhs: ShopFilter) -> Bool {
    guard lhs.types == rhs.types else { return false }
    guard lhs.specialists == rhs.specialists else { return false }
    guard lhs.targets == rhs.targets else { return false }
    return true
}

