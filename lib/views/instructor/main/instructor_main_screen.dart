import 'package:bb_sports/views/instructor/dashboard/instructor_dashboard_screen.dart';
import 'package:bb_sports/views/instructor/matches/instructor_matches_screen.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:bb_sports/views/instructor/home/instructor_home_screen.dart';
import 'package:bb_sports/views/instructor/profile/instructor_profile_screen.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/views/instructor/add_match/add_match_bottomsheet.dart';

class InstructorMainScreen extends StatefulWidget {
  const InstructorMainScreen({super.key});

  @override
  State<InstructorMainScreen> createState() => _InstructorMainScreenState();
}

class _InstructorMainScreenState extends State<InstructorMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const InstructorHomeScreen(),
    const InstructorDashboardScreen(),
    const InstructorMatchesScreen(),
    const InstructorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            selectedIcon: const Icon(
              Icons.home,
              color: ColorConstants.darkOrange,
            ),
            title: const Text('Home'),
            selectedColor: ColorConstants.darkOrange,
            unSelectedColor: ColorConstants.grey,
          ),
          BottomBarItem(
            icon: const Icon(Icons.dashboard_customize),
            selectedIcon: const Icon(
              Icons.dashboard,
              color: ColorConstants.darkOrange,
            ),
            title: const Text('Dashboard'),
            selectedColor: ColorConstants.darkOrange,
            unSelectedColor: ColorConstants.grey,
          ),

          BottomBarItem(
            icon: const Icon(Icons.sports_soccer_outlined),
            selectedIcon: const Icon(
              Icons.sports_soccer,
              color: ColorConstants.darkOrange,
            ),
            title: const Text('Matches'),
            selectedColor: ColorConstants.darkOrange,
            unSelectedColor: ColorConstants.grey,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(
              Icons.person,
              color: ColorConstants.darkOrange,
            ),
            title: const Text('Profile'),
            selectedColor: ColorConstants.darkOrange,
            unSelectedColor: ColorConstants.grey,
          ),
        ],
        fabLocation: StylishBarFabLocation.center,
        hasNotch: true,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
            builder: (context) => AddMatchBottomSheet(),
          );
        },
        backgroundColor: ColorConstants.primaryOrange,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
