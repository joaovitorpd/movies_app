// ignore_for_file: prefer_const_constructors_in_immutables, no_logic_in_create_state, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import '../blocs/movie_detail_bloc_provider.dart';
import '../models/trailer_model.dart';

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

  late MovieDetailBloc bloc;

  MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailersById(movieId);
    print("recreated");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

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
          body: ListView(
            children: [
              Padding(
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
                    Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Text(
                      "Trailer",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    StreamBuilder(
                      stream: bloc.movieTrailers,
                      builder: (context,
                          AsyncSnapshot<Future<TrailerModel>> snapshot) {
                        if (snapshot.hasData) {
                          return FutureBuilder(
                            future: snapshot.data,
                            builder: (context,
                                AsyncSnapshot<TrailerModel> itemSnapShot) {
                              if (itemSnapShot.hasData) {
                                if (itemSnapShot.data!.results.length > 0)
                                  return trailerLayout(itemSnapShot.data!);
                                else
                                  return noTrailer(itemSnapShot.data!);
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: Center(child: Icon(Icons.play_circle_filled)),
          ),
          Text(
            data.results[index].name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
