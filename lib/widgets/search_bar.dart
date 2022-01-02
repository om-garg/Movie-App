import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:provider/src/provider.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onTap;
  final VoidCallback onBack;
  final bool visibility;

  SearchBar({
    Key? key,
    this.visibility = true,
    required this.searchController,
    required this.onTap,
    required this.onBack,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.visibility == true
            ? GestureDetector(
                onTap: widget.onBack,
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.orangeAccent,
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: TextField(
            controller: widget.searchController,
            cursorColor: Colors.orangeAccent,
            style: const TextStyle(
                color: Colors.orangeAccent, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText:  context.watch<MovieData>().searchQuery.isEmpty ? 'Keyword...' : context.watch<MovieData>().searchQuery,
              hintStyle: TextStyle(
                  color: Colors.orangeAccent, fontWeight: FontWeight.w400),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.orangeAccent,
                width: 1,
              )),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent)),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        GestureDetector(
          onTap: widget.onTap,
          child: const Icon(
            Icons.search,
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }
}
