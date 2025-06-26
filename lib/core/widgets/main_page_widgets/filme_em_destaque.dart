import 'package:filmes_em_cartaz/presentation/pages/main_page.dart';
import 'package:filmes_em_cartaz/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:filmes_em_cartaz/presentation/pages/movie_details_page.dart';

class FilmeEmDestaque extends StatefulWidget {
  @override
  _FilmeEmDestaqueState createState() => _FilmeEmDestaqueState();
}

class _FilmeEmDestaqueState extends State<FilmeEmDestaque> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
              borderRadius: BorderRadius.circular(0),

              //para adicionar uma imagem de fundo
              //...
            ),
          ),

          Positioned(
            //top: 220,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: // botao de detalhes
                  ElevatedButton(
                onPressed:
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      ),
                    },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 91, 3, 3), // text color
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
            ),
          ),
        ],
      ),
    );
  }
}
