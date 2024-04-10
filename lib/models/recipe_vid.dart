class RecipeVideo {
  final String title;
  final String shortTitle;
  final String youTubeId;
  final double rating;
  final int views;
  final String thumbnail;
  final int length;

  RecipeVideo({
    required this.title,
    required this.shortTitle,
    required this.youTubeId,
    required this.rating,
    required this.views,
    required this.thumbnail,
    required this.length,
  });

  factory RecipeVideo.fromJson(Map<String, dynamic> json) {
    return RecipeVideo(
      title: json['title'],
      shortTitle: json['shortTitle'],
      youTubeId: json['youTubeId'],
      rating: json['rating'].toDouble(),
      views: json['views'],
      thumbnail: json['thumbnail'],
      length: json['length'],
    );
  }
}

class RecipeVideosResponse {
  final int totalResults;
  final List<RecipeVideo> videos;
  final int expires;

  RecipeVideosResponse({
    required this.totalResults,
    required this.videos,
    required this.expires,
  });

  factory RecipeVideosResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> videosJson = json['videos'];
    List<RecipeVideo> videos =
        videosJson.map((videoJson) => RecipeVideo.fromJson(videoJson)).toList();

    return RecipeVideosResponse(
      totalResults: json['totalResults'],
      videos: videos,
      
      expires: json['expires'],
    );
  }
}
