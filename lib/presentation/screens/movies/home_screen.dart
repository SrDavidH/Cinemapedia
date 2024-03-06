import 'package:cinemapedia/config/constansts/environment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

 static const name = 'home-screen';//nombre de la ruta

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Text( Environment.theMovieDbKey ),
      ),
    );
  }
}