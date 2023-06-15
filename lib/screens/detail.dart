import 'package:flutter/material.dart';
import 'package:tentwenty_techinical_assessment/screens/play.dart';
import 'package:tentwenty_techinical_assessment/screens/tickets.dart';
import '../constant/constant.dart';


class Detail extends StatelessWidget {
  final Map movieData;
  const Detail({Key? key,required this.movieData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _titlePath = movieData['backdrop_path'];
    final String movieName = movieData['title'];
    final String movieOverview = movieData['overview'];
    final int movieId = movieData['id'];
    final String releaseDate = movieData['release_date'];
    final List genreIds = movieData['genre_ids'];
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height / 2),
        child: SafeArea(

          child: AppBar(
            centerTitle: false,
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
            ),
            title: const Text("Watch",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            flexibleSpace: Stack(
              children: [
                FadeInImage.memoryNetwork(
                  height: 0.5*h,
                  placeholder: Constants().kTransparentImage,
                  image: "http://image.tmdb.org/t/p/w780/$_titlePath",
                  fit: BoxFit.fitHeight,
                ),
                Padding(padding: EdgeInsets.only(top: h*0.2),
                child: Center(
                  child: Column(
                    children: [
                      Text(movieName,style: const TextStyle(color: Color.fromRGBO(187,152,29, 1),fontWeight: FontWeight.bold,fontSize: 20),),
                      Text("In Theaters: $releaseDate",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return Tickets(releaseDate:releaseDate, title: movieName,);
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 0.7*w,
                          height: 0.06*h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue
                          ),
                          alignment: Alignment.center,
                          child: const Text("Get Tickets",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return Play(videoKey:movieId.toString(),);
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 0.7*w,
                          height: 0.06*h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2
                            )
                          ),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow,color: Colors.white,),
                              Text("  Watch Trailer",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 0.05*h,),
              const Text("Genres",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for (var item in genreIds)
                    (genre(item)!='')?Container(
                          margin: EdgeInsets.only(left: w * 0.01,top: 10),
                          padding:const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:Colors.orange,
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Text(genre(item),
                            style: const TextStyle(fontFamily: 'PopR',color: Colors.white),
                          ),
                        ):Container()
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("OverView",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 10.0),
              Text(
                movieOverview,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
  String genre(int id){
    String gen='';
    switch(id) {
      case 28:
        gen="Action";
        break;
      case 12:
        gen="Adventure";
        break;

      case 16:
        gen="Animation";
        break;
      case 35:
        gen="Comedy";
        break;
      case 80:
        gen="Crime";
        break;
      case 99:
        gen= "Documentary";
        break;
      case 18:
        gen= "Drama";
        break;
      case 10751:
        gen= "Documentary";
        break;
      case 14:
        gen= "Fantasy";
        break;
      case 36:
        gen= "History";
        break;
      case 27:
        gen= "Horror";
        break;
      case 10402:
      gen= "Music";
      break;
      case 9648:
        gen= "Mystery";
        break;
      case 10749:
        gen= "Romance";
        break;
      case 878:
        gen= "Science Fiction";
        break;
      case 10770:
        gen= "TV Movie";
        break;
      case 53:
        gen= "Thriller";
        break;
      case 10752:
        gen= "War";
        break;
      case 37:
        gen= "Western";
        break;
    }
    return gen;
    }
}
