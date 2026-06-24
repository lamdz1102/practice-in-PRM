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
// import 'package:flutter/material.dart';
// import 'app_structure_demo.dart';
// import 'home_screen.dart';
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
//   runApp(const MovieApp());
// }
//
// class _MyAppState extends State<MyApp> {
// // Biến kiểm tra Dark Mode đang bật hay tắt
// bool isDarkMode = false;
// class MovieApp extends StatelessWidget {
// const MovieApp({super.key});
//
// @override
// Widget build(BuildContext context) {
// return MaterialApp(
// title: 'Movie App',
// debugShowCheckedModeBanner: false,
//
// // Theme sáng
// theme: ThemeData(
// brightness: Brightness.light,
// primarySwatch: Colors.blue,
// primarySwatch: Colors.deepPurple,
// useMaterial3: true,
// ),
//
// // Theme tối
// darkTheme: ThemeData(
// brightness: Brightness.dark,
// useMaterial3: true,
// ),
//
// // Điều khiển chế độ theme
// themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
//
// home: AppStructureDemo(
// isDarkMode: isDarkMode,
// onThemeChanged: (value) {
// setState(() {
// isDarkMode = value;
// });
// },
// ),
// home: const HomeScreen(),
// );
// }
// }
//Lab 6
// import 'package:flutter/material.dart';
// import 'lab 6/lab6.dart';
//
// void main() {
//   runApp(const ResponsiveMovieApp());
// }
//Lab 7
// import 'package:flutter/material.dart';
//
// import 'lab 7/lab 7.1.dart';
// import 'lab 7/lab 7.2.dart';
// import 'lab 7/lab 7.3.dart';
// import 'lab 7/lab 7.4.dart';
//
// void main() {
//   runApp(const Lab7App());
// }
//
// class Lab7App extends StatelessWidget {
//   const Lab7App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Lab 7 - Forms and Validation',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.blue,
//       ),
//       home: const Lab7HomeScreen(),
//     );
//   }
// }
//
// class Lab7HomeScreen extends StatelessWidget {
//   const Lab7HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lab 7 - Forms and Validation'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const Text(
//             'Choose a lab exercise',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           _LabMenuCard(
//             title: 'Lab 7.1',
//             subtitle: 'Basic Registration Form',
//             icon: Icons.assignment,
//             screen: const Lab71BasicFormScreen(),
//           ),
//
//           _LabMenuCard(
//             title: 'Lab 7.2',
//             subtitle: 'Validation Rules & Password Strength',
//             icon: Icons.verified_user,
//             screen: const Lab72ValidationRulesScreen(),
//           ),
//
//           _LabMenuCard(
//             title: 'Lab 7.3',
//             subtitle: 'Focus & Keyboard Management',
//             icon: Icons.keyboard,
//             screen: const Lab73FocusKeyboardScreen(),
//           ),
//
//           _LabMenuCard(
//             title: 'Lab 7.4',
//             subtitle: 'Async Email Validation',
//             icon: Icons.cloud_sync,
//             screen: const Lab74AsyncValidationScreen(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _LabMenuCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Widget screen;
//
//   const _LabMenuCard({
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.screen,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => screen,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//Lab 8
// import 'package:flutter/material.dart';
//
// import 'lab 8/Lab 8.1.dart';
// import 'lab 8/Lab 8.2.dart';
// import 'lab 8/Lab 8.3.dart';
// import 'lab 8/Lab 8.4.dart';
//
// void main() {
//   runApp(const Lab8App());
// }
//
// class Lab8App extends StatelessWidget {
//   const Lab8App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Lab 8 - RESTful APIs & JSON',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.blue,
//       ),
//       home: const Lab8HomeScreen(),
//     );
//   }
// }
//
// class Lab8HomeScreen extends StatelessWidget {
//   const Lab8HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lab 8 - APIs & JSON'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const Text(
//             'Choose a Lab 8 exercise',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           _LabMenuCard(
//             title: 'Lab 8.1',
//             subtitle: 'Simple GET Request',
//             icon: Icons.download,
//             screen: const Lab81SimpleGetScreen(),
//           ),
//
//           _LabMenuCard(
//             title: 'Lab 8.2',
//             subtitle: 'JSON Model & Detail Screen',
//             icon: Icons.data_object,
//             screen: const Lab82JsonModelScreen(),
//           ),
//
//           _LabMenuCard(
//             title: 'Lab 8.3',
//             subtitle: 'POST Request & Error Handling',
//             icon: Icons.upload,
//             screen: const Lab83PostRequestScreen(),
//           ),
//
//           _LabMenuCard(
//             title: 'Lab 8.4',
//             subtitle: 'ApiService Pattern',
//             icon: Icons.api,
//             screen: const Lab84ApiServiceScreen(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _LabMenuCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Widget screen;
//
//   const _LabMenuCard({
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.screen,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => screen,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//Lab 8B
// import 'package:flutter/material.dart';
//
// import 'lab 8B/weather_screen.dart';
//
// void main() {
//   runApp(const Lab8BApp());
// }
//
// class Lab8BApp extends StatelessWidget {
//   const Lab8BApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Lab 8B - Weather Companion',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.blue,
//       ),
//       home: const WeatherScreen(),
//     );
//   }
// }
//Lab 9
import 'package:flutter/material.dart';

import 'lab 9/lab 9.1.dart';
import 'lab 9/lab 9.2.dart';
import 'lab 9/lab 9.3.dart';

void main() {
  runApp(const Lab9App());
}

class Lab9App extends StatelessWidget {
  const Lab9App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Lab9Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Lab9Home extends StatelessWidget {
  const Lab9Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 9 - JSON Storage")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menu(context, "9.1 Read JSON Assets", const Lab91()),
          _menu(context, "9.2 Local Storage", const Lab92()),
          _menu(context, "9.3 CRUD + Search", const Lab93()),
        ],
      ),
    );
  }

  Widget _menu(BuildContext c, String title, Widget page) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}