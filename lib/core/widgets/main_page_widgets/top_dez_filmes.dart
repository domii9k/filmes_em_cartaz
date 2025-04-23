import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopDezFilmes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopDezFilmes();
}

class _TopDezFilmes extends State<TopDezFilmes> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 245,
      child: CarouselSlider(
        items: [

          // Item 1
          SizedBox(
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Poster do filme
                Container(
                  height: 216, // Altura fixa para o poster
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.claquete.com.br/fotos/filmes/poster/8485_medio.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                // Nome do filme
                const SizedBox(height: 8),
                Text(
                  'Nome do filme',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
        options: CarouselOptions(
          height: 245,
          aspectRatio: 2 / 3,
          viewportFraction: 0.35,
          enlargeCenterPage: false,
          autoPlay: true,
          enableInfiniteScroll: true,
        ),
      ),
    );
  }
}
