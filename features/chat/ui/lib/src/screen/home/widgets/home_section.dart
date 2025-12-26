import 'package:chat_ui/src/screen/home/widgets/chat_history.dart';
import 'package:chat_ui/src/screen/home/widgets/user_section.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  int tabIndex = 0;
  bool pinned = true;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        setState(() => pinned = notification.scrollDelta?.isNegative ?? false);
        return false;
      },
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, _) => [
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 4,
            pinned: pinned,
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
