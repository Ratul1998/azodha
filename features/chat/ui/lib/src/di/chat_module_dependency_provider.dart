import 'package:chat_ui/src/screen/chat/cubit/chat_cubit.dart';
import 'package:chat_ui/src/screen/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class ChatModuleDependencyProvider {
  static void register() {
    final di = GetIt.instance;

    di.registerFactory(() => HomeCubit(interactor: di.get()));

    di.registerFactoryParam<ChatCubit, int, void>(
      (chatId, _) => ChatCubit(interactor: di.get(), chatId: chatId),
    );
  }
}
