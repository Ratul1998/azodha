import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:chat_ui/src/screen/home/cubit/home_cubit.dart';
import 'package:chat_ui/src/screen/home/cubit/home_state.dart';
import 'package:chat_api/api.dart';

import '../mocks.dart';

void main() {
  late MockChatInteractor interactor;

  setUp(() {
    interactor = MockChatInteractor();
  });

  final users = [
    UserModel(
      id: 1,
      name: 'Alice',
      username: 'alice',
      email: 'a@test.com',
      address: Address(
        street: '',
        suite: '',
        city: '',
        zipcode: '',
        geo: Geo(lat: '0', lng: '0'),
      ),
      phone: '',
      website: '',
      company: Company(name: '', catchPhrase: '', bs: ''),
    ),
  ];

  final chats = [ChatModel(userId: 1, chatId: 1, message: 'Chat 1')];

  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Loaded] when initialize succeeds',
      build: () {
        when(() => interactor.getUsers()).thenAnswer((_) async => users);
        when(() => interactor.getUserChat()).thenAnswer((_) async => chats);

        return HomeCubit(interactor: interactor);
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [
        isA<HomeStateLoaded>()
            .having((s) => s.users, 'users', users)
            .having((s) => s.chats, 'chats', chats),
      ],
      verify: (_) {
        verify(() => interactor.getUsers()).called(1);
        verify(() => interactor.getUserChat()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Error] when initialize fails',
      build: () {
        when(
          () => interactor.getUsers(),
        ).thenAnswer((_) => Future.error(Exception('error')));

        when(() => interactor.getUserChat()).thenAnswer((_) async => chats);

        return HomeCubit(interactor: interactor);
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [isA<HomeStateError>()],
    );
  });
}
