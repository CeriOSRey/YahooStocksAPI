//
//  File.swift
//  
//
//  Created by Rey Cerio on 2022-12-27.
//

import Foundation

public struct SearchTickerResponse: Decodable {
    
    enum CodingKeys: CodingKey {
        case quotes
        case finance
    }
    
    enum FinanceKeys: CodingKey {
        case error
    }
    
    public let data: [Ticker]?
    public let error: ErrorResponse?
    
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decodeIfPresent([Ticker].self, forKey: .quotes)
        error = try? container.nestedContainer(keyedBy: FinanceKeys.self, forKey: .finance)
            .decodeIfPresent(ErrorResponse.self, forKey: .error)
    }
    
}

public struct Ticker: Codable, Identifiable, Hashable, Equatable {
    
    public let id = UUID()
    
    public let symbol: String
    public let quoteType: String?
    public let shortName: String?
    public let longName: String?
    public let sector: String?
    public let industry: String?
    public let exchDisp: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.quoteType = try container.decodeIfPresent(String.self, forKey: .quoteType)
        self.shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        self.longName = try container.decodeIfPresent(String.self, forKey: .longName)
        self.sector = try container.decodeIfPresent(String.self, forKey: .sector)
        self.industry = try container.decodeIfPresent(String.self, forKey: .industry)
        self.exchDisp = try container.decodeIfPresent(String.self, forKey: .exchDisp)
    }
    
}
