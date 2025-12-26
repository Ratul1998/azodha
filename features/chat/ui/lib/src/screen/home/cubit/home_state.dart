import 'package:chat_api/api.dart';

abstract class HomeState {}

class HomeStateLoading implements HomeState {}

class HomeStateLoaded implements HomeState {
  final List<UserModel> users;
  final List<ChatModel> chats;

  const HomeStateLoaded({required this.users, required this.chats});
}

class HomeStateError implements HomeState {
  final Object error;
  final StackTrace? trace;

  const HomeStateError({this.trace, required this.error});
}
