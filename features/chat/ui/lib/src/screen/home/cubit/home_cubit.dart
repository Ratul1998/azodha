import 'package:bloc/bloc.dart';
import 'package:chat_api/api.dart';
import 'package:chat_ui/src/screen/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ChatInteractor _interactor;

  HomeCubit({required ChatInteractor interactor})
    : _interactor = interactor,
      super(HomeStateLoading());

  void initialize() =>
      Future.wait([
            _interactor.getUsers(),
            _interactor.getUserChat(),
          ], eagerError: true)
          .then((data) {
            emit(
              HomeStateLoaded(
                chats: data.last as List<ChatModel>,
                users: [
                  ...(data.first as List<UserModel>),
                  ...(data.first as List<UserModel>),
                ],
              ),
            );
          })
          .onError<Exception>((err, str) {
            emit(HomeStateError(error: err, trace: str));
          });
}
