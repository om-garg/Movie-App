import 'package:flutter/material.dart';
import 'package:movie_app/screens/detail_screen.dart';

class MovieTile extends StatefulWidget {
  final String imgUrl, title, desc, rating;
  const MovieTile({
    Key? key,
    required this.desc,
    required this.imgUrl,
    required this.title,
    required this.rating,
  }) : super(key: key);

  @override
  State<MovieTile> createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailScreen(
              rating: widget.rating,
              description: widget.desc,
              imageUrl: widget.imgUrl,
              title: widget.title,
            )
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                widget.imgUrl,
                width: 150,
                fit: BoxFit.cover,
                height: 200,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: const Color(0xff151A23).withOpacity(0.6),
                  alignment: Alignment.center,
                  width: 150,
                  height: 68,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    child: Column(
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.desc,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
