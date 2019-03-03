//
//  IRequestSender.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

public struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

public enum Result<Model> {
    case success(Model)
    case error(String)
}

public protocol IRequestSender {
    func send<Parser>(requestConfig: RequestConfig<Parser>,
                      completionHandler: @escaping(Result<Parser.Model>) -> Void) -> URLSessionDataTask?
}
