import 'package:anime_ui/src/screen/home_page/cubit/home_cubit.dart';
import 'package:anime_ui/src/screen/home_page/widgets/search_anime_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'widgets/home_section.dart';
import 'widgets/new_release_anime_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final di = GetIt.instance;

    final pages = [HomeSection(), SearchAnimeSection(), NewReleasesSection()];

    return BlocProvider(
      create: (_) => di.get<HomeCubit>()..loadData(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: pages[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              label: 'New Releases',
            ),
          ],
        ),
      ),
    );
  }
}
