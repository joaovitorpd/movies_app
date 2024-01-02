// ignore_for_file: prefer_const_constructors_in_immutables, no_logic_in_create_state, prefer_const_constructors

import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  final String? posterUrl;
  final String? description;
  final String? releaseDate;
  final String? title;
  final String? voteAverage;
  final int? movieId;

  MovieDetail({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId,
    );
  }
}

class MovieDetailState extends State<MovieDetail> {
  final String? posterUrl;
  final String? description;
  final String? releaseDate;
  final String? title;
  final String? voteAverage;
  final int? movieId;

  MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  "https://image.tmdb.org/t/p/w500$posterUrl",
                  fit: BoxFit.cover,
                )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0)),
                title != null
                    ? Text(
                        title!,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "no title",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    voteAverage != null
                        ? Text(
                            voteAverage!,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          )
                        : Text(
                            "no average",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    releaseDate != null
                        ? Text(
                            releaseDate!,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          )
                        : Text(
                            "no releaseDate",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                description != null
                    ? Text(description!)
                    : Text("no description"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
