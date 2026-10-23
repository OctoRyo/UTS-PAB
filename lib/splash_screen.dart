import 'dart:async';  
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Berpindah otomatis ke MainNavigation setelah 3 detik
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animasi Lottie Splash
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/lottie/Cute Tiger.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            // Nama Aplikasi
            const Text(
              'PawPal Care Center',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            Text(
              'Perawatan Terbaik untuk Anabul Kesayangan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            // Indikator Loading
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}