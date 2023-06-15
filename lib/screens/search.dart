import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tentwenty_techinical_assessment/constant/trending.dart';
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

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchMovies(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Image.asset('assets/images/loading.gif'),
            );
          } else {
            return MoviesCard(movieData:snapshot.data.movies);
          }
        },
      ),
    );
  }
}


class MoviesCard extends StatefulWidget {
  final List movieData;
  const MoviesCard({Key? key,required this.movieData}) : super(key: key);

  @override
  State<MoviesCard> createState() => _MoviesCardState();
}

class _MoviesCardState extends State<MoviesCard> {

  TextEditingController searchController=TextEditingController();
  String searchText='';


  @override
  Widget build(BuildContext context) {
    OutlineInputBorder clrBorder=  OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(color:Color.fromRGBO(237, 231, 230,1), ),
    );
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(

              controller: searchController,
              autofocus: true,
              style: const TextStyle(color: Colors.black,fontFamily: 'PopR'),
              onChanged: (value){
                setState(() {
                  searchText=value.trim();
                });
                print(searchText);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(237, 231, 230,1),
                  border: clrBorder,
                  enabledBorder: clrBorder,
                  focusedBorder: clrBorder,
                  errorBorder: clrBorder,
                  focusedErrorBorder: clrBorder,
                  hintText: "Search",
                  contentPadding: const EdgeInsets.only(top: 5,bottom: 5),
                  hintStyle: const TextStyle(color: Colors.black26,fontFamily: 'PopR'),
                  suffixIcon: IconButton(
                    onPressed: (){
                    searchController.clear();
                    setState(() {
                      searchText='';
                    });
                  }, icon: const Icon(Icons.close_outlined,),),
                  prefixIcon: const Icon(Icons.search,color: Colors.black)
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            color: const Color.fromRGBO(237, 231, 230,1),
            height: h*0.85,
            width: w*1,
            child:(searchText!='')?ListView.builder(
              itemCount: widget.movieData.length,
              itemBuilder: (context, index) {
                final String posterPath = widget.movieData[index]['poster_path'];
                return (widget.movieData[index]['title'].toLowerCase().contains(searchText.toLowerCase()))?InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return Detail(movieData:widget.movieData[index]);
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: w * 0.35,
                        height: h*0.2,
                        child: ClipRRect(
                            borderRadius:  BorderRadius.circular(10),
                            child: Image.network('http://image.tmdb.org/t/p/w780/$posterPath',fit: BoxFit.cover,)),
                      ),
                      // SizedBox(width: w*0.2,),
                      Center(
                        child: FittedBox(
                            fit:BoxFit.cover,
                            child: SizedBox(
                                width:w*0.5,
                                height:h*0.2,
                                child: Center(child: Text(widget.movieData[index]['title'],style: const TextStyle(fontSize:20,fontWeight: FontWeight.bold),)))),
                      ),
                    ],
                  ),
                ):Container();
              },
            ):GridView.builder(
              shrinkWrap: true,
              itemCount: widget.movieData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0
              ),
              itemBuilder: (BuildContext context, int index){
                final String posterPath = widget.movieData[index]['poster_path'];
                return Stack(
                  children: [
                    InkWell(
                      onTap: (){
                        // print(movieData[index]['id']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return Detail(movieData:widget.movieData[index]);
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
                        padding: EdgeInsets.only(left: 20,top: h*0.18),
                        child: Text(widget.movieData[index]['title'],style: const TextStyle(fontSize:20,color: Colors.white,fontWeight: FontWeight.bold),)

                    ),
                  ],
                );
              },
            )
          ),
        ],
      ),
    );
  }
}
