import 'package:filmes_em_cartaz/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';

class FilmeEmDestaque extends StatefulWidget {
  @override
  _FilmeEmDestaqueState createState() => _FilmeEmDestaqueState();
}

class _FilmeEmDestaqueState extends State<FilmeEmDestaque> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        clipBehavior: Clip.antiAlias,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 15),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),

              //para adicionar uma imagem de fundo
              //...
            ),
          ),

          Positioned(
            //top: 220,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 15),
                height: 100,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(48),
                ),

                //detalhes resumidos do filme em destaque
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //titulo e descrição resumida
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Titulo',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rating',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // botao de detalhes
                      ElevatedButton(
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
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF767676), // text color
                        ),
                        child: Text(
                          'Detalhes',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
