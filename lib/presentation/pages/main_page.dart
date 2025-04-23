import 'package:filmes_em_cartaz/core/widgets/main_page_widgets/top_dez_filmes.dart';
import 'package:flutter/material.dart';
import 'package:filmes_em_cartaz/core/widgets/main_page_widgets/cabecalho.dart';
import 'package:filmes_em_cartaz/core/widgets/main_page_widgets/filme_em_destaque.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(color: Color(0xFF121011)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Cabecalho(), // cabeçalho
                //conteudo da pagina
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FilmeEmDestaque(),

                        //TOP DEZ FILMES
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Top 10 Filmes',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Ver todos >',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            TopDezFilmes(),

                            SizedBox(height: 16),
                          ],
                        ),

                        //filmes de terror
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Filmes de terror',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Ver todos >',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
