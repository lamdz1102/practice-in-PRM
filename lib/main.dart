//LAB 4
// import 'package:flutter/material.dart';
// import 'app_structure_demo.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// // Hàm main dùng để chạy thử Exercise 4
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // Biến kiểm tra Dark Mode đang bật hay tắt
//   bool isDarkMode = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       // Theme sáng
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//
//       // Theme tối
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         useMaterial3: true,
//       ),
//
//       // Điều khiển chế độ theme
//       themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
//
//       home: AppStructureDemo(
//         isDarkMode: isDarkMode,
//         onThemeChanged: (value) {
//           setState(() {
//             isDarkMode = value;
//           });
//         },
//       ),
//     );
//   }
// }

//Lab 5
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}