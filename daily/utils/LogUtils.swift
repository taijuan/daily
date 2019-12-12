//MARK: 输出日志
//
class LogUtils {
    // MARK: info 输出日志
    static func info(_ message: Any) {
        #if DEBUG
        let log = "LogUtils 💙 - " + "\(message)"
        print(log)
        #endif
    }
    
    // MARK: success 输出日志
    static func success(_ message: Any) {
        #if DEBUG
        let log  = "LogUtils 💚 - " + "\(message)"
        print(log)
        #endif
    }
    
    // MARK: error 输出日志
    static  func error(_ message: Any) {
        #if DEBUG
        let log  = "LogUtils ❤️ - " + "\(message)"
        print(log)
        #endif
    }
    
    // MARK: warning 输出日志
    static func warning(_ message: Any) {
        #if DEBUG
        let log  = "LogUtils 💛 - " + "\(message)"
        print(log)
        #endif
    }
}
