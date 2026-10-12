# NerX / Collab Offer Demo

A compact SwiftUI demo that turns the original logo screen into an interactive offer browser. It is intentionally smaller than CollabMN: three sample offers, search, bookmarks, a saved-offers filter, and a detail sheet.

## Run

Open `nerdemo.xcodeproj` in Xcode and select the `nerdemo` scheme. The source uses iOS 17 SwiftUI APIs.

Search by brand, title, or category. Tap the bookmark to save an offer on this device, then use the saved filter. Open an offer to see its reward and description.

All content is sample data. The app does not create accounts or send applications, and bookmarks persist in local preferences. VoiceOver labels identify the logo and each bookmark action.

The minimum deployment target is iOS 17. An unsigned device build passes in Xcode. CI builds the app and checks bookmark persistence, toggling, and malformed stored data. Real-device and simulator interaction still need testing.

```sh
mkdir -p build
swiftc nerdemo/BookmarkCodec.swift tests/main.swift -o build/bookmark-tests
build/bookmark-tests
xcodebuild -project nerdemo.xcodeproj -scheme nerdemo -sdk iphoneos -destination 'generic/platform=iOS' -derivedDataPath build/DerivedData CODE_SIGNING_ALLOWED=NO build
```
