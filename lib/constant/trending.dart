class Upcoming {
   List? movies;
  Upcoming({this.movies});

  factory Upcoming.fromJson(Map<String, dynamic> json) {
    return Upcoming(
      movies: json['results'],
    );
  }
}