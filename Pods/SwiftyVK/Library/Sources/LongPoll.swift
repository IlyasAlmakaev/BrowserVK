import Foundation

private var lpQueue = DispatchQueue(label: "VKLongPollQueue")

private typealias VKLongPoll = VK
extension VKLongPoll {
    /**
     Long pool client. More - https://vk.com/dev/using_longpoll
     * To start and stop the server, use the start() and stop() functions
     * To check the activity of the client, use the isActive property
     * To subscribe to notifications, use NSNotificationCenter using the names of VK.LP.notifications
     */
    public struct LP {
        public private(set) static var isActive: Bool = false
        private static var connectionObserver: ConnectionObserver?
        private static let updateQueue: OperationQueue = {
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            return queue
        }()
        private static var isConnected = false
        
        ///Starting receiving updates from the long pool server
        public static func start() {
            lpQueue.sync {
                guard !isActive else {
                    VK.Log.put("LongPoll", "LongPoll is already active")
                    return
                }
                
                isActive = true
                
                connectionObserver = ConnectionObserver(
                    onConnect: {
                        lpQueue.async {
                            if isActive {
                                isConnected = true
                                NotificationCenter.default.post(name: VK.LP.notifications.connectinDidRestore, object: nil)
                                startUpdating()
                            }
                        }
                    },
                    onDisconnect: {
                        lpQueue.async {
                            if isActive {
                                isConnected = false
                                NotificationCenter.default.post(name: VK.LP.notifications.connectinDidLost, object: nil)
                                updateQueue.cancelAllOperations()
                            }
                        }
                    }
                )
                
                VK.Log.put("LongPoll", "Stared")
            }
        }
        
        ///Pause receiving updates from the long pool server
        public static func stop() {
            lpQueue.sync {
                updateQueue.cancelAllOperations()
                connectionObserver = nil
                isActive = false
                VK.Log.put("LongPoll", "Stopped")
            }
        }
        
        // swiftlint:disable:next large_tuple
        private static func getConnectionInfo(completion: @escaping ((server: String, lpKey: String, ts: String)?) -> ()) {
            guard isActive, VK.state == .authorized else {
                VK.Log.put("LongPoll", "User is not authorized")
                completion(nil)
                return
            }
            
            let semaphore = DispatchSemaphore(value: 0)
            var result: (server: String, lpKey: String, ts: String)?
            
            var req = VK.API.Messages.getLongPollServer([VK.Arg.useSsl: "0", VK.Arg.needPts: "1"])
            req.catchErrors = false
            req.maxAttempts = 1
            
            VK.Log.put("LongPoll", "Getting server info with \(req)")
            req.send(
                onSuccess: {response in
                    defer {
                        semaphore.signal()
                    }
                    
                    VK.Log.put("LongPoll", "get server info with \(req)")
                    
                    guard
                        let server = response["server"].string,
                        let lpKey = response["key"].string else {
                            return
                    }
                    
                    let ts = response["ts"].stringValue
                    
                    result = (server, lpKey, ts)
                },
                onError: {_ in
                    VK.Log.put("LongPoll", "Error get server info with \(req)")
                    semaphore.signal()
                }
            )
            
            semaphore.wait()
            
            guard let realResult = result else {
                lpQueue.asyncAfter(deadline: .now() + 1) {
                    getConnectionInfo(completion: completion)
                }
                return
            }
            
            completion(realResult)
        }
        
        private static func startUpdating() {
            guard isActive else {
                VK.Log.put("LongPoll", "Long poll not active")
                return
            }
            
            getConnectionInfo { connectionInfo in
                guard let connectionInfo = connectionInfo else {
                    VK.Log.put("LongPoll", "Fail to get connection info")
                    return
                }
                
                VK.Log.put("LongPoll", "Start updating")
                
                let updateOperation = LongPollUpdatingOperation(
                    server: connectionInfo.server,
                    lpKey: connectionInfo.lpKey,
                    startTs: connectionInfo.ts,
                    onResponse: { updates in
                        parse(updates)
                    },
                    onKeyExpired: {
                        updateQueue.cancelAllOperations()
                        lpQueue.async {
                            startUpdating()
                        }
                    }
                )
                
                updateQueue.cancelAllOperations()
                
                if isConnected {
                    updateQueue.addOperation(updateOperation)
                }
            }
        }
        
        // swiftlint:disable cyclomatic_complexity
        private static func parse(_ updates: [JSON]?) {
            guard let updates = updates else {return}
            
            var all = [JSON]()
            var updates0 = [JSON]()
            var updates1 = [JSON]()
            var updates2 = [JSON]()
            var updates3 = [JSON]()
            var updates4 = [JSON]()
            var updates6 = [JSON]()
            var updates7 = [JSON]()
            var updates8 = [JSON]()
            var updates9 = [JSON]()
            var updates51 = [JSON]()
            var updates61 = [JSON]()
            var updates62 = [JSON]()
            var updates70 = [JSON]()
            var updates80 = [JSON]()
            
            for update in updates {
                all.append(update)
                switch update[0].intValue {
                case 0:
                    updates0.append(update)
                case 1:
                    updates1.append(update)
                case 2:
                    updates2.append(update)
                case 3:
                    updates3.append(update)
                case 4:
                    updates4.append(update)
                case 6:
                    updates6.append(update)
                case 7:
                    updates7.append(update)
                case 8:
                    updates8.append(update)
                case 9:
                    updates9.append(update)
                case 51:
                    updates51.append(update)
                case 61:
                    updates61.append(update)
                case 62:
                    updates62.append(update)
                case 70:
                    updates70.append(update)
                case 80:
                    updates80.append(update)
                default:
                    break
                }
            }
            
            !updates0.isEmpty ? NotificationCenter.default.post(name: notifications.type0, object: JSONWrapper(updates0)) : ()
            !updates1.isEmpty ? NotificationCenter.default.post(name: notifications.type1, object: JSONWrapper(updates1)) : ()
            !updates2.isEmpty ? NotificationCenter.default.post(name: notifications.type2, object: JSONWrapper(updates2)) : ()
            !updates3.isEmpty ? NotificationCenter.default.post(name: notifications.type3, object: JSONWrapper(updates3)) : ()
            !updates4.isEmpty ? NotificationCenter.default.post(name: notifications.type4, object: JSONWrapper(updates4)) : ()
            !updates6.isEmpty ? NotificationCenter.default.post(name: notifications.type6, object: JSONWrapper(updates6)) : ()
            !updates7.isEmpty ? NotificationCenter.default.post(name: notifications.type7, object: JSONWrapper(updates7)) : ()
            !updates8.isEmpty ? NotificationCenter.default.post(name: notifications.type8, object: JSONWrapper(updates8)) : ()
            !updates9.isEmpty ? NotificationCenter.default.post(name: notifications.type9, object: JSONWrapper(updates9)) : ()
            !updates51.isEmpty ? NotificationCenter.default.post(name: notifications.type51, object: JSONWrapper(updates51)) : ()
            !updates61.isEmpty ? NotificationCenter.default.post(name: notifications.type61, object: JSONWrapper(updates61)) : ()
            !updates62.isEmpty ? NotificationCenter.default.post(name: notifications.type62, object: JSONWrapper(updates62)) : ()
            !updates70.isEmpty ? NotificationCenter.default.post(name: notifications.type70, object: JSONWrapper(updates70)) : ()
            !updates80.isEmpty ? NotificationCenter.default.post(name: notifications.type80, object: JSONWrapper(updates80)) : ()
            !all.isEmpty ? NotificationCenter.default.post(name: notifications.typeAll, object: JSONWrapper(all)) : ()
        }
        // swiftlint:enable cyclomatic_complexity
        
        
        // swiftlint:disable type_name
        public enum notifications {
            // swiftlint:enable type_name
            
            ///0,$message_id,0 — delete a message with the local_id indicated
            public static let type0 = Notification.Name("VKLPNotificationType0")
            ///1,$message_id,$flags — replace message flags (FLAGS:=$flags)
            public static let type1 = Notification.Name("VKLPNotificationType1")
            ///2,$message_id,$mask[,$user_id] — install message flags (FLAGS|=$mask)
            public static let type2 = Notification.Name("VKLPNotificationType2")
            ///3,$message_id,$mask[,$user_id] — reset message flags (FLAGS&=~$mask)
            public static let type3 = Notification.Name("VKLPNotificationType3")
            ///4,$message_id,$flags,$from_id,$timestamp,$subject,$text,$attachments — add a new message
            public static let type4 = Notification.Name("VKLPNotificationType4")
            ///6,$peer_id,$local_id — read all incoming messages with up to $peer_id $local_id inclusive
            public static let type6 = Notification.Name("VKLPNotificationType6")
            ///7,$peer_id,$local_id — read all incoming messages with up to $peer_id $local_id inclusive
            public static let type7 = Notification.Name("VKLPNotificationType7")
            ///8,-$user_id,$extra — each $user_id has become online,
            ///$extra is not equal to 0 if the flag was handed over to mode 64, in the low byte (remainder of the division by 256) of $extra lying platform identifier
            public static let type8 = Notification.Name("VKLPNotificationType8")
            ///9,-$user_id,$flags — each $user_id has become offline ($flags is 0 if the user has left the site (for example, pulled out), and 1 if the offline timeout (eg, status away))
            public static let type9 = Notification.Name("VKLPNotificationType9")
            ///51,$chat_id,$self — one of the parameters (composition, theme) $chat_id conversations have changed. $self - whether the changes are caused by the user
            public static let type51 = Notification.Name("VKLPNotificationType51")
            ///61,$user_id,$flags — user $user_id began typing in the dialog. event should come again in about 5 seconds at a constant typing. $flags = 1
            public static let type61 = Notification.Name("VKLPNotificationType61")
            ///62,$user_id,$chat_id — user $user_id began write in the dialog $chat_id
            public static let type62 = Notification.Name("VKLPNotificationType62")
            ///70,$user_id,$call_id — user $user_id makes call with ID $call_id
            public static let type70 = Notification.Name("VKLPNotificationType70")
            ///80,$count,0 — New unread counts in the left menu has become equal to $count
            public static let type80 = Notification.Name("VKLPNotificationType80")
            ///List of all updates
            public static let typeAll = Notification.Name("VKLPNotificationTypeAll")
            ///The connection was lost
            public static let connectinDidLost = Notification.Name("VKLPNotificationConnectinDidLost")
            ///The connection was connected again
            public static let connectinDidRestore = Notification.Name("VKLPNotificationConnectinDidRestore")
        }
    }
}
//
//
//
//
//
//
//
//
//
//
///The wrapper for a variety of objects such as JSON to be compatible with NSObject. Access to the property is via an unwrap array
public final class JSONWrapper {
    public let unwrap: [JSON]
    
    public init(_ value: [JSON]) {
        self.unwrap = value
    }
}
