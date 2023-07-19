import 'package:flutter/material.dart';
import 'package:hotspot/src/blocs/bloc_exports.dart';
import 'package:hotspot/src/blocs/info/info_bloc.dart';
import 'main_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});
  static const id = 'tabs_screen';

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InfoBloc>().add(getInfoEvent());
  }

  final List<Map<String, dynamic>> _pageDetails = [
    {'pagename': const MainScreen(), 'title': 'Main'},
    {'pagename': const SearchScreen(), 'title': 'Search'},
    {'pagename': const ProfileScreen(), 'title': 'Profile'},
  ];

  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageDetails[_selectedPageIndex]['pagename'],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
