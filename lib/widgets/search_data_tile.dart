import 'package:flutter/material.dart';
import 'package:movie_app/screens/detail_screen.dart';

class SearchDataTile extends StatelessWidget {
  final String title;
  final String description;
  final String urlToImage;
  final String voteAverage;

  const SearchDataTile({
    required this.title,
    required this.urlToImage,
    required this.description,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailScreen(
              rating: voteAverage,
              description: description,
              imageUrl: urlToImage,
              title: title,
            )
        ));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.30,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white24,
                      spreadRadius: 3,
                      blurRadius: 20,
                      offset: Offset(4, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    urlToImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      description,
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orangeAccent,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          voteAverage.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const Text(
                          ' /10',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
