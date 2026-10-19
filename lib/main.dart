import 'package:flutter/material.dart';
import 'package:flutter_application_1/ArticlesScreen.dart';
import 'package:flutter_application_1/HomeScreen.dart';
import 'package:flutter_application_1/ProfileScreen.dart';
import 'package:flutter_application_1/ServicesScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const PawPalApp());
}

class PawPalApp extends StatelessWidget {
  const PawPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawPal Care Center',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppins(
          Theme.of(context).textTheme,
        ),
      ),
      home:  MainNavigation(),
    );
  }
}

// Wrapper Navigasi 4 Menu Utama (Wajib Minimum 4 Menu)
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ServicesScreen(),
    const ArticlesScreen(),
    const ProfileScreen(), // Menu Profile Wajib
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}