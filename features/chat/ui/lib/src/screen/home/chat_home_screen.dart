import 'package:chat_ui/src/screen/home/cubit/home_cubit.dart';
import 'package:chat_ui/src/screen/home/widgets/home_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final di = GetIt.instance;

    return BlocProvider(
      create: (context) => di.get<HomeCubit>()..initialize(),
      child: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: navIndex,
              children: const [
                HomeSection(),
                Center(child: Text('Offers')),
                Center(child: Text('Settings')),
              ],
            ),
          ),
          bottomNavigationBar: _BottomNav(
            selectedIndex: navIndex,
            onChange: (val) => setState(() => navIndex = val),
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChange;

  const _BottomNav({required this.selectedIndex, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onChange,
      currentIndex: selectedIndex,
      elevation: 4,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Offers"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
