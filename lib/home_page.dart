import 'package:flutter/material.dart';
import 'package:project/widgets/Keypad/keypad.dart';
import 'package:project/widgets/Recents/recents.dart';
import 'package:project/widgets/Contacts/table_user.dart';

var kBottomBarBackgroundColor = Colors.black;
var kBottomBarForegroundActiveColor = Colors.white;
var kBottomBarForegroundInactiveColor = Colors.white60;
var kSplashColor = Colors.black;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required Map userData}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> userDataList = [];

  void _handleUserFound(Map<String, dynamic> userData) {
    setState(() {
      userDataList.add(userData);
    });
  }

  void _handleClickButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildPageBody() {
      switch (_selectedIndex) {
        case 0:
          return Keypad(onUserFound: _handleUserFound);
        case 1:
          return RecentsUser(userDataList: userDataList); // Pass userData to Recents
        case 2:
          return TableUser();
        default:
          return Keypad(onUserFound: _handleUserFound);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 70.0,),
            SizedBox(width: 70.0,),
            Icon(Icons.search , color: Colors.white,),
          ],
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 64.0,
        padding: EdgeInsets.zero,
        color: kBottomBarBackgroundColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: AppBottomMenuItem(
                iconData: Icons.dialpad,
                text: 'Keypad',
                isSelected: _selectedIndex == 0,
                onClick: () {
                  _handleClickButton(0);
                },
              ),
            ),
            Expanded(
              child: AppBottomMenuItem(
                iconData: Icons.recent_actors,
                text: 'Recents',
                isSelected: _selectedIndex == 1,
                onClick: () {
                  _handleClickButton(1);
                },
              ),
            ),
            Expanded(
              child: AppBottomMenuItem(
                iconData: Icons.contacts,
                text: 'Contacts',
                isSelected: _selectedIndex == 2,
                onClick: () => _handleClickButton(2),
              ),
            ),
          ],
        ),
      ),
      body: buildPageBody(),
    );
  }
}


class AppBottomMenuItem extends StatelessWidget {
  AppBottomMenuItem({
    super.key,
    required this.iconData,
    required this.text,
    required this.isSelected,
    required this.onClick,
  });

  final IconData iconData;
  final String text;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected
        ? kBottomBarForegroundActiveColor
        : kBottomBarForegroundInactiveColor;

    return ClipOval(
      child: Material(
        color: Colors.transparent, // button color
        child: InkWell(
          // splashColor: kSplashColor,
          onTap: onClick, // button pressed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(iconData, color: color),
              SizedBox(height: 4.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: color,
                  // fontWeight: isSelected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
