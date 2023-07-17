import 'package:flutter/material.dart';
import 'package:learn_movie_app/screens/dashboard.dart';
import 'package:learn_movie_app/screens/favourites.dart';
import 'package:learn_movie_app/screens/movie_selection.dart';
import 'package:learn_movie_app/screens/ticket_payment.dart';
import 'package:learn_movie_app/screens/profile.dart';

void main(List<String> args) {
  runApp(const MovieBoard());
}

class MovieBoard extends StatefulWidget {
  const MovieBoard({Key? key}) : super(key: key);

  @override
  State<MovieBoard> createState() => _MovieBoardState();
}

class _MovieBoardState extends State<MovieBoard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Dashboard(),
    MovieSelection(),
    const Favorites(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.blue,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_4x4), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
