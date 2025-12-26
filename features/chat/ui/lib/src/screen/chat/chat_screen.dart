import 'dart:math';

import 'package:chat_api/api.dart';
import 'package:chat_ui/src/screen/chat/cubit/chat_cubit.dart';
import 'package:chat_ui/src/screen/chat/cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChatScreen extends StatelessWidget {
  final UserModel user;
  final int chatId;
  const ChatScreen({super.key, required this.user, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final di = GetIt.instance;

    return BlocProvider(
      create: (context) => di.get<ChatCubit>(param1: chatId)..loadData(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            elevation: 2,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(child: Text(user.name[0])),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name),
                    const Text("Online", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          body: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) => switch (state) {
              ChatStateLoaded _ => ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.messages.length,
                itemBuilder: (_, i) => MessageBubble(
                  message: state.messages[i],
                  isMe: Random().nextBool(),
                ),
              ),
              ChatErrorState _ => ErrorWidget(state.error),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!isMe) CircleAvatar(child: Text(message.name[0].toUpperCase())),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(maxWidth: 260),
              decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16).copyWith(
                  topRight: Radius.circular(isMe ? 4 : 16),
                  topLeft: Radius.circular(isMe ? 16 : 4),
                ),
              ),
              child: Text(
                message.body,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              ),
            ),
            if (isMe) CircleAvatar(child: Text(message.name[0])),
          ],
        ),
      ),
    );
  }
}
