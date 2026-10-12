import Foundation

enum BookmarkCodec {
    static func decode(_ data: Data) -> Set<Int> {
        let ids = (try? JSONDecoder().decode([Int].self, from: data)) ?? []
        return Set(ids.filter { $0 > 0 })
    }

    static func toggling(_ id: Int, in data: Data) -> Data {
        guard id > 0 else { return data }
        var ids = decode(data)
        if ids.contains(id) { ids.remove(id) }
        else { ids.insert(id) }
        return (try? JSONEncoder().encode(ids.sorted())) ?? Data()
    }
}
