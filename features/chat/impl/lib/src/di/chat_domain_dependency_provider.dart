import 'package:chat_api/api.dart';
import 'package:chat_impl/src/domain/chat_interactor.dart';
import 'package:chat_impl/src/service/chat_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

abstract class ChatDomainDependencyProvider {
  static void register() {
    final di = GetIt.instance;
    final baseUrl = 'https://jsonplaceholder.typicode.com';
    di.registerLazySingleton(
      () => ChatService(dio: Dio(BaseOptions(baseUrl: baseUrl))),
    );
    di.registerLazySingleton<ChatInteractor>(
      () => ChatInteractorImpl(service: di.get()),
    );
  }
}
