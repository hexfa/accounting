import 'package:accounting/core/constants/enums/device_screen_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  final List<Widget> _pages = const [
    Center(child: Text('محصولات')),
    Center(child: Text('مشتری‌ها')),
    Center(child: Text('سفارشات')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = getDeviceType(constraints);

        if (deviceType == DeviceScreenType.desktop) {
          return Scaffold(
            body: Row(
              children: [
                const SizedBox(
                  width: 250,
                  child: Drawer(
                    elevation: 0,
                    child: AppSideMenu(),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).colorScheme.primary,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        tabs: const [
                          Tab(text: 'محصولات'),
                          Tab(text: 'مشتری‌ها'),
                          Tab(text: 'سفارشات'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: _pages,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('اپ حسابداری')),
            drawer: const Drawer(child: AppSideMenu()),
            body: _pages[selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) => setState(() => selectedIndex = index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'محصولات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'مشتری‌ها',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: 'سفارشات',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class AppSideMenu extends StatelessWidget {
  const AppSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(child: Text('منوی اصلی')),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('تغییر زبان'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('تغییر تم'),
          onTap: () {},
        ),
      ],
    );
  }
}
