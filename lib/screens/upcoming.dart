import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tentwenty_techinical_assessment/constant/trending.dart';
import 'package:tentwenty_techinical_assessment/screens/play.dart';
import 'package:tentwenty_techinical_assessment/screens/search.dart';
import 'detail.dart';


Future<Upcoming> fetchMovies() async {
  final response = await http
      .get(Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=3b83ef7227c10c65c365801b3a5c4c00"));
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return Upcoming.fromJson(json.decode(response.body));
  } else {
    throw Exception('not able to Fetch the Upcoming Movies');
  }
}

class UpcomingMovies extends StatefulWidget {
  const UpcomingMovies({super.key});

  @override
  UpcomingMoviesState createState() => UpcomingMoviesState();
}

class UpcomingMoviesState extends State<UpcomingMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return const Search();
                },
              ),
            );
          }, icon: const Icon(Icons.search,)),
          const SizedBox(width: 10,)
        ],
      ),
      body: FutureBuilder(
        future: fetchMovies(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Image.asset('assets/images/loading.gif'),
            );
          } else {
            return HorizontalCards(movieData:snapshot.data.movies);
          }
        },
      ),
    );
  }
}


class HorizontalCards extends StatelessWidget {
  final List movieData;
  const HorizontalCards({Key? key,required this.movieData}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Container(
      color: const Color.fromRGBO(237, 231, 230,1),
      height: h* 1,
      width: w*1,
      child: ListView.builder(
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          final String posterPath = movieData[index]['poster_path'];
          return Stack(
            children: [
              InkWell(
                onTap: (){
                  print(movieData[index]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return Detail(movieData:movieData[index]);
                      },
                    ),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) {
                  //       return Play(videoKey:movieData[index]['id'].toString(),);
                  //     },
                  //   ),
                  // );
                },
                child: Container(

                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: w * 0.9,
                  height: h*0.24,
                  child: ClipRRect(
                      borderRadius:  BorderRadius.circular(10),
                      child: Image.network('http://image.tmdb.org/t/p/w780/$posterPath',fit: BoxFit.cover,)),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20,top: h*0.22),
                  child: Text(movieData[index]['title'],style: const TextStyle(fontSize:20,color: Colors.white,fontWeight: FontWeight.bold),)

              ),
            ],
          );
        },
      ),
    );
  }
}
