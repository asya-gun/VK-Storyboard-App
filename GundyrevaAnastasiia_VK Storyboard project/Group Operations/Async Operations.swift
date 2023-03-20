//
//  Async Operations.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 19.03.2023.
//

// операции загрузки данных с сервера
// парсинг
// сохранение в рилм

import Foundation
import Alamofire

class AsyncOperation: Operation {
    
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    override var isAsynchronous: Bool {
        return true
    }
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    override var isExecuting: Bool {
        return state == .executing
    }
    override var isFinished: Bool {
        return state == .finished
    }
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    override func cancel() {
        super.cancel()
        state = .finished
    }
}

class GetGroupsOperation: AsyncOperation {
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private var request: DataRequest
    
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
}

class ParseGroupsOperation: Operation {
    var outputData: [Group] = []
    private let decoder = JSONDecoder()
    
    override func main() {
        guard let getGroupsOperation = dependencies.first(where: { $0 is GetGroupsOperation}) as? GetGroupsOperation,
              let data = getGroupsOperation.data else { return }
        do {
            let response = try decoder.decode(GroupResponse.self, from: data)
//            let groups: [Group] = try response.decode([Group].self, from: data)
            outputData = Array(response.response.items)
        } catch {
            print("Data not decoded")
        }
    }
}
