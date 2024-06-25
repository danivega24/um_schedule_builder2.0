import 'package:flutter/material.dart';
import 'package:schedule_builder_um/pages/add_classes_page.dart';
import 'package:schedule_builder_um/pages/filtered_page.dart';
import 'package:schedule_builder_um/pages/test_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final List _pages = [
    const AddClassesPage(), 
    const FilteredPage(), 
    const TestPage(), 
  ];


void navigateBottomBar(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).primaryColorDark,

        currentIndex: _selectedIndex,
        onTap: navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: "Add Classes",
          ),
          
          BottomNavigationBarItem(
              icon: Icon(Icons.local_gas_station_rounded),
              label: "Filter Classes"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_rounded),
              label: "Test"
          ),
        ],
      ),
    );
  }
}