import Foundation

protocol TaskCompletion: AnyObject {
    var id: UUID { get set }
    var taskId: UUID { get set }
    var day: Day { get set }
    
    func validate() -> Bool
    func equals(_ completion: TaskCompletion) -> Bool
    func copyFrom(_ completion: TaskCompletion) -> Void
}

extension TaskCompletion {
    func validate() -> Bool {
        true
    }
    
    func equals(_ completion: TaskCompletion) -> Bool {
        id == completion.id &&
        taskId == completion.taskId &&
        day == completion.day
    }
    
    func copyFrom(_ completion: TaskCompletion) {
        self.id = completion.id
        self.taskId = completion.taskId
        self.day = completion.day
    }
}
