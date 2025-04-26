import 'package:filmes_em_cartaz/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopDezFilmes extends StatefulWidget {
  const TopDezFilmes({super.key});

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
          // item 1
          SizedBox(
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // poster do filme
                Stack(
                  children: <Widget>[
                    Container(
                      height: 216, // altura fixa para o poster
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

                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed:
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const MovieDetailsPage(),
                                ),
                              ),
                            },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(5),
                          backgroundColor: Color.fromARGB(255, 208, 85, 85),
                          foregroundColor: Colors.redAccent[900],
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          weight: 20,
                        ),
                      ),
                    ),
                  ],
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
