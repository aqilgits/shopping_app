import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/cart.screen.dart';
import 'package:shopping_app/Screens/item.screen.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  int _idx = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  // transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return const CartScreen(
                      userId: '123',
                    );
                  },
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
              print('Shopping cart'); // Add your profile icon onTap logic here
            },
          ),
        ],
      ),
      body: _getBody(_idx),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _idx,
        // backgroundColor: colorScheme.surface,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        // selectedLabelStyle: textTheme.caption,
        // unselectedLabelStyle: textTheme.caption,
        onTap: ((value) {
          setState(() {
            _idx = value;
          });
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }

  _getBody(int value) {
    switch (value) {
      case 0:
        return const Item();
      case 1:
        return const Item();
      case 2:
        return const Item();
    }
  }
}
