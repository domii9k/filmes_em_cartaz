import 'package:filmes_em_cartaz/presentation/pages/favorite.dart';
import 'package:filmes_em_cartaz/presentation/pages/main_page.dart';
import 'package:filmes_em_cartaz/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _pages() {
    return [MainPage(), SearchPage(), Favorite()];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Início",
        textStyle: TextStyle(fontWeight: FontWeight.w500),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: "Buscar",
        textStyle: TextStyle(fontWeight: FontWeight.w500),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu),
        title: "Menu",
        textStyle: TextStyle(fontWeight: FontWeight.w500),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Início'),
            onTap: () {
              setState(() {
                _controller.index = 0;
              });
              Navigator.pop(_scaffoldKey.currentContext!);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Buscar'),
            onTap: () {
              setState(() {
                _controller.index = 1;
              });
              Navigator.pop(_scaffoldKey.currentContext!);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoritos'),
            onTap: () {
              setState(() {
                _controller.index = 2;
              });
              Navigator.pop(_scaffoldKey.currentContext!);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final responsive = screenSize.width >= 600;

    if (responsive) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Filmes em Cartaz'),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: _buildDrawer(),
        body: _pages()[_controller.index],
      );
    } else {
      return PersistentTabView(
        context,
        controller: _controller,
        screens: _pages(),
        items: _navBarItems(),
        confineToSafeArea: true,
        backgroundColor: Color(0xFF1E1E1E),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 5),
        navBarHeight: 82,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(38.0),
          colorBehindNavBar: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 232, 100, 100).withValues(alpha: 0.5),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
          ),
        ),
        navBarStyle: NavBarStyle.style1,
      );
    }
  }
}