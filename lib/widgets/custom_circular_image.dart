import 'dart:io';


import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';



enum CustomFileType { asset, network, file }

class CustomCircularImage extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  final String imageUrl;
  final CustomFileType fileType;
  final File? image;
  final BoxFit? fit;
  final Border? border;
  const CustomCircularImage({
    Key? key,
    required this.imageUrl,
    this.image,
    this.height = 60,
    this.width = 60,
    this.borderRadius,
    this.fileType = CustomFileType.network,
    this.fit,
    this.border
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      padding: border==null?null:EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius??height),
          border: border,
          image:fileType==CustomFileType.asset?  DecorationImage(
              image: AssetImage(
                  imageUrl
              )
          ):fileType==CustomFileType.file?
          DecorationImage(
              image: FileImage(
                  image!
              ), fit: fit??BoxFit.cover)
              :
          // DecorationImage(
          //   image: NetworkImage(
          //     imageUrl
          //   ),
          //
          //   fit: fit??BoxFit.cover,
          // ),
          null
      ),
      child: fileType==CustomFileType.network?CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit??BoxFit.cover,
        placeholder: (context, url) => Padding(
          padding: const EdgeInsets.all(14.0),
          // child: CustomLoader(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ):null,

    );
  }
}

