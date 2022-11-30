import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sparebboxx/utils/constant.dart';


class NetworkImageWidget extends StatelessWidget {

  final String imageUrl;

   const NetworkImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
        ],
      ),
      errorWidget: (context, url, error) =>  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FaIcon(FontAwesomeIcons.user,size: 30,color: Colors.black,),
        ],
      ),
    );
  }
}


class NetworkProfileImageWidget extends StatelessWidget {

  final String imageUrl;

  const NetworkProfileImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      placeholder: (context, url) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
        ],
      ),
      errorWidget: (context, url, error) =>  SizedBox(
          height: 120,
          width: 120,
          child: ClipRRect(
              borderRadius: borderRadius,
              child: Image.asset("assets/images (2).png",fit: BoxFit.fill,))),
    );
  }
}


class NetworkImageChatHeadWidget extends StatelessWidget {

  final String imageUrl;

  const NetworkImageChatHeadWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 55,
      height: 55,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.grey.shade300
        ),
      ),
      errorWidget: (context, url, error) =>  SizedBox(
          height: 55,
          width: 55,
          child: ClipRRect(
              borderRadius: borderRadius,
              child: Image.asset("assets/images (2).png",fit: BoxFit.fill,))),
    );
  }
}

