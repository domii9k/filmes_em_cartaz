import 'package:filmes_em_cartaz/core/widgets/movie_datails_widgets/elenco_carrossel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key});

  @override
  State<StatefulWidget> createState() => _MovieDatailsPage();
}

class _MovieDatailsPage extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: 413,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber[400],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(55),
                  bottomRight: Radius.circular(55),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //voltar e mais opcoes
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              backgroundColor: Color(0xFF121011),
                              foregroundColor: Colors.redAccent[900],
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              weight: 10,
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              backgroundColor: Color(0xFF121011),
                              foregroundColor: Colors.redAccent[900],
                            ),
                            child: Icon(
                              Symbols.more_vert_rounded,
                              color: Colors.white,
                              weight: 2000,
                              opticalSize: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //detalhes do filme
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            Container(
                              height: 800,
                              width: 356,
                              decoration: BoxDecoration(
                                color: Color(0xFF1E1E1E),
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 30,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'NOME DO FILME',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          'GENERO DO FILME BLA BLA BLA BLA',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.white54,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Classificação'),
                                                  Text('L'),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Duração'),
                                                  Text('1hr30min'),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Lançamento'),
                                                  Text('20/04/2025'),
                                                ],
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Disponível em'),
                                              Text('ENG, PTBR, PTPT'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Divider(
                                      thickness: 2,
                                      color: Colors.white54,
                                    ),

                                    //sinopse
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Sinopse'),
                                          Text(
                                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Colors.white54,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Trailers'),
                                          Container(
                                            margin: EdgeInsets.only(top: 10, bottom: 10),
                                            height: 200,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  'https://m.media-amazon.com/images/I/31J9SblmIjL.png',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Divider(
                                      thickness: 2,
                                      color: Colors.white54,
                                    ),

                                    //elenco
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Elenco'),
                                          ElencoCarrossel(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                    //comprar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
