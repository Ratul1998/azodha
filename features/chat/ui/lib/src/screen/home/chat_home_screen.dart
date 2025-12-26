import 'package:chat_ui/src/screen/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'widgets/chat_history.dart' show ChatHistoryPage;
import 'widgets/user_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final di = GetIt.instance;

    return BlocProvider(
      create: (context) => di.get<HomeCubit>()..initialize(),
      child: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (_, _) => [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  elevation: 2,
                  centerTitle: true,
                  title: _TopSwitcher(
                    index: tabIndex,
                    onChanged: (i) => setState(() => tabIndex = i),
                  ),
                ),
              ],
              body: IndexedStack(
                index: tabIndex,
                children: const [UsersListPage(), ChatHistoryPage()],
              ),
            ),
          ),
          floatingActionButton: tabIndex == 0
              ? FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      kMinInteractiveDimension,
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('User added')));
                  },
                  child: const Icon(Icons.add),
                )
              : null,
          bottomNavigationBar: const _BottomNav(),
        ),
      ),
    );
  }
}

class _TopSwitcher extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const _TopSwitcher({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Tab(
            label: "Users",
            selectedIndex: index,
            index: 0,
            onChanged: onChanged,
          ),
          _Tab(
            label: "Chat History",
            index: 1,
            selectedIndex: index,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _Tab({
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: selected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      elevation: 4,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Offers"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
