//
//  APIClient.swift
//  ReactiveSwift
//
//  Created by Hasan Akoglu on 08/03/2021.
//

import Foundation
import RxNetworking
import RxCocoa
import RxDataSources
import RxSwift

struct Course: Decodable, Equatable {
    let id: Int!
    let name: String!
    let link, imageURL: String!
    let numberOfLessons: Int!

    enum CodingKeys: String, CodingKey {
        case id, name, link
        case imageURL
        case numberOfLessons
    }
}

protocol APIClientProtocol {
    func fetchCourses() -> Observable<[Course]>
}

class APIClient: APIClientProtocol {
    lazy var requestObservable = RequestObservable(config: .default)
    
    func fetchCourses() -> Observable<[Course]> {
        var request = URLRequest(url: URL(string:"https://api.letsbuildthatapp.com/jsondecodable/courses")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return requestObservable.callAPI(request: request)
    }
}

//MARK: RequestObservable class
public class RequestObservable {
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    
    public init(config: URLSessionConfiguration) {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    //MARK: function for URLSession takes
    public func callAPI<ItemModel: Decodable>(request: URLRequest) -> Observable<ItemModel> {
        //MARK: creating our observable
        return Observable.create { observer in
            //MARK: create URLSession dataTask
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse{
                    let statusCode = httpResponse.statusCode
                    do {
                        let _data = data ?? Data()
                        if (200...399).contains(statusCode) {
                            let objs = try self.jsonDecoder.decode(ItemModel.self, from: _data)
                            //MARK: observer onNext event
                            observer.onNext(objs)
                        }
                        else {
                            observer.onError(error!)
                        }
                    } catch {
                        //MARK: observer onNext event
                        observer.onError(error)
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }
            task.resume()
            //MARK: return our disposable
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
