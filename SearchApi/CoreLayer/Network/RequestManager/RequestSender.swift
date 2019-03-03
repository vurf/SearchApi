//
//  RequestSender.swift
//  SearchApi
//
//  Created by i.varfolomeev on 01/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation

class RequestSender: IRequestSender {
    
    let session = URLSession.shared
    
    func send<Parser>(requestConfig config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model>) -> Void) -> URLSessionDataTask? {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(Result.error("Не удалось преобразовать URL"))
            return nil
        }
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(Result.error(error.localizedDescription))
                return
            }
            
            guard let data = data, let parsedModel: Parser.Model = config.parser.parse(data: data) else {
                completionHandler(Result.error("Не удалось распарсить данные"))
                return
            }
            
            completionHandler(Result.success(parsedModel))
        }
        
        task.resume()
        return task
    }
}
