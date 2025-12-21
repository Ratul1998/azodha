# Flutter Todo App

## Setup
1. Flutter SDK >= 3.0
2. flutter pub get
3. flutter run

## Assumptions
- JSONPlaceholder is a mock API for GET data
- POST/PATCH/DELETE working locally 

## BLoC Pattern
- Events trigger actions
- Bloc handles business logic
- UI rebuilds via BlocBuilder

## Offline Strategy
- Hive for caching
- Optimistic UI updates
- Sync pending changes on reconnect

## Challenges
- Handling optimistic updates
- Sync conflict resolution

## Demo Video
[Demo Video](https://github.com/Ratul1998/azodha/blob/master/Screen_recording_20251221_222905.mp4)
