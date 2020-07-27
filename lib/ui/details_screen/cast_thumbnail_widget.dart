import 'package:cine_reel/constants/api_constants.dart';
import 'package:cine_reel/models/tmdb_movie_details.dart';
import 'package:cine_reel/navigation/router.dart';
import 'package:cine_reel/ui/common_widgets/common_widgets.dart';
import 'package:cine_reel/ui/common_widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const castHeight = 280.0;

class CastThumbnailWidget extends StatelessWidget {
  final TMDBMovieDetails movieDetails;

  CastThumbnailWidget({TMDBMovieDetails this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildThumbnails(),
        buildHorizontalDivider(context),
      ],
    );
  }

  Container buildThumbnails() {
    return Container(
      child: SizedBox.fromSize(
        size: const Size.fromHeight(castHeight),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieDetails.credits != null
              ? movieDetails.credits.cast.length
              : 8,
          itemBuilder: (BuildContext context, int index) {
            Cast cast =
                movieDetails.hasData ? movieDetails.credits.cast[index] : null;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: _buildAvatar(context, index, cast)),
                _buildCastName(cast),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, int index, Cast cast) {
    return Container(
        child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Router.goToPersonDetailsScreen(context, cast),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildPhotoThumbnail(cast, index),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildCastName(Cast cast) {
    return Container(
      width: 140.0,
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        children: <Widget>[
          _buildName(cast),
          _buildCharacter(cast),
        ],
      ),
    );
  }

  Widget _buildName(Cast cast) {
    return Center(
      child: Text(
        cast.name,
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }

  Widget _buildCharacter(Cast cast) {
    if (cast.hasCharacter()) {
      return Center(
        child: Text(
          "(${cast.character})",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0),
        ),
      );
    }
    return Container();
  }

  Widget _buildPhotoThumbnail(Cast cast, int index) {
    return Expanded(
      child: Hero(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: ImageLoader(
                  animate: true,
                  imagePath: cast.profilePath,
                  imageType: IMAGE_TYPE.PROFILE,
                  size: PROFILE_SIZES[PROFILE_SIZE],
                )),
          ),
        ),
        tag: "${cast.id}-${cast.name}",
      ),
    );
  }
}
