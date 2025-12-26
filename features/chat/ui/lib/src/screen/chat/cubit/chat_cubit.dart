import 'package:bloc/bloc.dart';
import 'package:chat_api/api.dart';
import 'package:chat_ui/src/screen/chat/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatInteractor _interactor;

  ChatCubit({required ChatInteractor interactor, required int chatId})
    : _interactor = interactor,
      super(ChatLoadingState(chatId: chatId));

  void loadData() => _interactor
      .getMessages(state.chatId)
      .then(
        (messages) =>
            emit(ChatStateLoaded(messages: messages, chatId: state.chatId)),
      )
      .onError<Exception>((err, str) {
        emit(ChatErrorState(error: err, chatId: state.chatId, str: str));
      });
}
