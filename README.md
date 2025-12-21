# Flutter Todo App

## Setup
1. Flutter SDK >= 3.0
2. flutter pub get
3. flutter run

## Assumptions
- JSONPlaceholder is a mock API
- Auth is local-only

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
