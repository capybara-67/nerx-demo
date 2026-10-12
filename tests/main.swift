import Foundation

var bytes = BookmarkCodec.toggling(1, in: Data())
bytes = BookmarkCodec.toggling(3, in: bytes)
precondition(BookmarkCodec.decode(bytes) == [1, 3])
let suiteName = "bookmark-test-\(UUID().uuidString)"
let defaults = UserDefaults(suiteName: suiteName)!
defaults.set(bytes, forKey: "saved-offer-ids")
let restored = UserDefaults(suiteName: suiteName)!.data(forKey: "saved-offer-ids")!
precondition(BookmarkCodec.decode(restored) == [1, 3])
precondition(BookmarkCodec.decode(BookmarkCodec.toggling(1, in: restored)) == [3])
precondition(BookmarkCodec.decode(Data("bad json".utf8)).isEmpty)
precondition(BookmarkCodec.decode(Data("[1,1,-2,0]".utf8)) == [1])
defaults.removePersistentDomain(forName: suiteName)
print("Bookmark persistence checks passed")
