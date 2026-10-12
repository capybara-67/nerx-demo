# NerX / Collab Offer Demo

A compact SwiftUI demo that turns the original logo screen into an interactive offer browser. It is intentionally smaller than CollabMN: three sample offers, search, bookmarks, a saved-offers filter, and a detail sheet.

## Run

Open `nerdemo.xcodeproj` in Xcode and select the `nerdemo` scheme. The source uses iOS 17 SwiftUI APIs.

Search by brand, title, or category. Tap the bookmark to save an offer for the current visit, then use the saved filter. Open an offer to see its reward and description.

All content is sample data. The app does not create accounts or send applications, and bookmarks reset on restart. VoiceOver labels identify the logo and each bookmark action.

Swift source typechecks against the iOS SDK. Full simulator testing remains to be completed on a machine with available simulator runtimes.
