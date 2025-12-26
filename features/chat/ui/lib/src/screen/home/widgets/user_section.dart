import 'dart:math';

import 'package:chat_ui/src/screen/home/cubit/home_cubit.dart';
import 'package:chat_ui/src/screen/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => switch (state) {
            HomeStateLoaded _ => ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (_, i) {
                final u = state.users[i];
                final isOnline = Random().nextInt(5).isEven;

                return ListTile(
                  leading: Badge(
                    alignment: Alignment(1, .5),
                    backgroundColor: isOnline
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        u.name[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  title: Text(u.name),
                  subtitle: Text(
                    isOnline
                        ? 'Online'
                        : '${Random().nextInt(50) + 1} mins ago',
                  ),
                );
              },
            ),
            HomeStateError _ => ErrorWidget(state.error),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kMinInteractiveDimension),
            ),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('User added')));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
