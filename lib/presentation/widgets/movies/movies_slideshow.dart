import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;

  const MoviesSlideshow({
    super.key, 
  required this.movies});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,// infinito de forma horizontal
      child: Swiper(
        viewportFraction: 0.8, //nos permite separar las plantillas
        scale: 0.85,// espacio entre cada plantilla
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return _Slide(movie: movies[index]);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(//este nos sirve para agregar una sobra en la parte de abajo
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0,10)//poder bajar el nivel de la sombra, entrem mas positivo sea mas baja y negativo sube, tanto en x y y
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only( bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child:  ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
             if(loadingProgress != null){
              return const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black12)
                  );
             }

              return FadeIn(child: child);// este child hace referencia al image.network

            },
            )
          )
          ),
    );
  }
}