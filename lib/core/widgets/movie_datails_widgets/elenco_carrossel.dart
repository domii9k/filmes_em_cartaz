import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ElencoCarrossel extends StatelessWidget {
  const ElencoCarrossel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      height: 70,
      child: CarouselSlider(
        items: [

          SizedBox(
            width: 70,
            child: Container(
              height: 70, // altura fixa para o poster
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://ntvb.tmsimg.com/assets/assets/669726_v9_bc.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // item 1
          SizedBox(
            width: 70,
            child: Container(
              height: 70, // altura fixa para o poster
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://ntvb.tmsimg.com/assets/assets/669726_v9_bc.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),


          SizedBox(
            width: 70,
            child: Container(
              height: 70, // altura fixa para o poster
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1240w,f_auto,q_auto:best/rockcms/2023-04/230405-donald-glover-se-518p-57bcdb.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 70,
            child: Container(
              height: 70, // altura fixa para o poster
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://m.media-amazon.com/images/M/MV5BMmNhMDQ1YjktYTg1Ny00Mjg0LWFmZTgtMmE0OTkxYmQzYzVlXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 70,
            child: Container(
              height: 70, // altura fixa para o poster
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://ntvb.tmsimg.com/assets/assets/669726_v9_bc.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Container(
              height: 70, // altura fixa para o poster
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://ntvb.tmsimg.com/assets/assets/669726_v9_bc.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 70,
          viewportFraction: 0.25,
          //aspectRatio: 2/3,
          enlargeCenterPage: false,
          autoPlay: false,
          enableInfiniteScroll: false,
          padEnds: false
          
        ),
      ),
    );
  }
}
