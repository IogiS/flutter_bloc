import 'package:flutter/material.dart';

class NavigationBarUI extends StatefulWidget {
  Function(int index) onTabChange;
  int? selectedIndex;
  NavigationBarUI({Key? key, required this.onTabChange, this.selectedIndex})
      : super(key: key);

  @override
  _NavigationBarUIState createState() => _NavigationBarUIState(onTabChange);
}

class _NavigationBarUIState extends State<NavigationBarUI> {
  late Function(int index) onTabChange;
  int _selectedIndex = 0;

  _NavigationBarUIState(onTabChange) {
    this.onTabChange = onTabChange;
  }
  @override
  void initState() {
    if (widget.selectedIndex != null) {
      setState(() {
        _selectedIndex = widget.selectedIndex!;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            label: 'Albums',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'User',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (clickedIndex) {
          setState(() {
            _selectedIndex = clickedIndex;
            onTabChange(_selectedIndex);
          });
        });
  }
}
