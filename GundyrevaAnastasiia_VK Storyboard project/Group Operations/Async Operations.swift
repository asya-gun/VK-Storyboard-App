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
import RealmSwift

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

class SaveGroupsToRealmOperation: Operation {
    let realm: Realm
    let groups: [Group]
    
    init(realm: Realm, groups: [Group]) {
        self.realm = realm
        self.groups = groups
    }
    
    override func main() {
        DispatchQueue.main.async {
            let allGroups = self.realm.objects(GroupItems.self)
            var groupItems = GroupItems()
            
            for i in self.groups.indices {
                let oneGroup = Group()
                oneGroup.id = self.groups[i].id
                oneGroup.name = self.groups[i].name
                oneGroup.photo = self.groups[i].photo
                oneGroup.groupDescription = self.groups[i].groupDescription
                groupItems.items.append(oneGroup)
    //            print(oneGroup.name)
            }
            print(groupItems.items)
            
            if allGroups.isEmpty {
    //            try! realm.write {
    //                realm.add(groupItems)
    //            }
                print("Groups are empty, but the operation is working")
            } else {
                print("Groups aren't empty, but the operation is working")
            }
        }
      
    }
    
}
