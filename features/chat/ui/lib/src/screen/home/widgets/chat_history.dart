import 'dart:math';

import 'package:chat_ui/src/screen/chat/chat_screen.dart';
import 'package:chat_ui/src/screen/home/cubit/home_cubit.dart';
import 'package:chat_ui/src/screen/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => switch (state) {
        HomeStateLoaded _ => ListView.builder(
          itemCount: state.chats.length,
          itemBuilder: (_, i) {
            final c = state.chats[i];
            final user = state.users.firstWhere((user) => user.id == c.userId);
            final unreadMsg = Random().nextInt(5);
            final lastOnline = Random().nextInt(50);
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  user.name[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Row(
                children: [
                  Expanded(child: Text(user.name)),
                  Text(
                    lastOnline < 5 ? 'Online' : '$lastOnline mins ago',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              subtitle: Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Text(
                      c.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (unreadMsg > 0)
                    Container(
                      height: 16,
                      width: 16,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        unreadMsg.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(user: user, chatId: c.chatId),
                  ),
                );
              },
            );
          },
        ),
        HomeStateError _ => ErrorWidget(state.error),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
