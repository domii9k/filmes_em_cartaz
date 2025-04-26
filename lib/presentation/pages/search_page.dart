import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color.fromARGB(255, 49, 49, 49),
                    foregroundColor: Colors.redAccent[900],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    weight: 20,
                  ),
                ),
                Container(
                  width: 300,
                  height: 55,
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 49, 49, 49),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Procure o filme aqui...',
                      suffixIcon: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          backgroundColor: Color.fromARGB(255, 49, 49, 49),
                          foregroundColor: Colors.redAccent[900],
                        ),
                        onPressed: () => (),
                        child: Icon(Icons.filter_alt_outlined, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
