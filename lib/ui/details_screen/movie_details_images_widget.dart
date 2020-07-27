import 'package:cine_reel/constants/api_constants.dart';
import 'package:cine_reel/models/tmdb_movie_details.dart';
import 'package:cine_reel/navigation/router.dart';
import 'package:cine_reel/ui/common_widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieDetailsImagesWidget extends StatelessWidget {
  final TMDBMovieDetails movieDetails;

  MovieDetailsImagesWidget({TMDBMovieDetails this.movieDetails});

  @override
  Widget build(BuildContext context) {
    List<TMDBImage> backdrops = movieDetails.backdrops;

    if (backdrops.length > 1) {
      return buildBackdrops(backdrops);
    }
    return Container();
  }

  AspectRatio buildBackdrops(List<TMDBImage> backdrops) {
    return AspectRatio(
      child: PageView.builder(
        itemCount: backdrops.length - 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          //index+1 to ignore first image as we already show it in the header
          String imagePath = backdrops[index + 1].filePath;
          return GestureDetector(
            onTap: () => Router.goToImageSlideshow(context, backdrops, index),
            child: Hero(
              child: ImageLoader(
                imageType: IMAGE_TYPE.BACKDROP,
                imagePath: imagePath,
                size: BACKDROP_SIZES[SIZE_LARGE],
              ),
              tag: "$imagePath + $index}",
            ),
          );
        },
      ),
      aspectRatio: 16.0 / 9.0,
    );
  }
}
