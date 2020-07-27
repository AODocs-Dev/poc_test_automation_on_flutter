import 'package:cine_reel/constants/api_constants.dart';
import 'package:cine_reel/ui/common_widgets/image_loader.dart';
import 'package:flutter/material.dart';

class MovieDetailsHeaderWidget extends StatelessWidget {
  final String backdropPath;

  final int id;

  MovieDetailsHeaderWidget(
      {@required this.backdropPath, @required this.id});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //using half of the width as height, makes the backdrop to not overflow on any screen
    double height = width * 0.50; 

    return Column(
      children: <Widget>[
        Hero(
          tag: "$id-$backdropPath",
          child: SizedBox(
            width: width,
            height: height,
            child: ClipPath(
              clipper: BackdropClipper(),
              child: ImageLoader(
                imageType: IMAGE_TYPE.BACKDROP,
                imagePath: backdropPath,
                size: BACKDROP_SIZES[SIZE_LARGE],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackdropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var clipHeight = 30.0;
    var startPoint = Offset(0.0, size.height - clipHeight);
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - clipHeight);

    path.lineTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0); //top right corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
