import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/naviagtion/app_router.dart';

import '../dashboard/view/dashboard_screen.dart';
import '../leads/view/leads_screen.dart';
import '../search/view/search_screen.dart';
import '../profile/view/profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  int _currentIndex = 0;

  final Color primaryColor = const Color(0xFF562B80);

  final List<Widget> _screens = const [
    DashboardScreen(),
    LeadsScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 4;

    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, MyAppRouter.addLead);
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          children: [

            /// NAV BAR CONTAINER
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  _navItem(Icons.dashboard_outlined, "Dashboard", 0),
                  _navItem(Icons.people_outline, "Leads", 1),
                  _navItem(Icons.search, "Search", 2),
                  _navItem(Icons.person_outline, "Profile", 3),

                ],
              ),
            ),

            /// TOP INDICATOR
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: itemWidth * _currentIndex + 20,
              top: 0,
              child: Container(
                width: itemWidth - 40,
                height: 4,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );

  }

  Widget _navItem(IconData icon, String label, int index) {

    final bool isSelected = _currentIndex == index;

    return GestureDetector(

      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },

      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              color: isSelected
                  ? primaryColor
                  : Colors.grey.shade500,
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? primaryColor
                    : Colors.grey.shade500,
              ),
            ),

          ],
        ),
      ),
    );

  }

}