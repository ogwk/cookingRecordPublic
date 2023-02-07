import 'dart:io';
import 'package:flutter/material.dart';

Widget imageBox(height, width, filepath) {
  return FittedBox(
      fit: BoxFit.fill,
      child: Container(
          width: height,
          height: width,
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: filepath == "" ? Colors.grey : Colors.white10,
            shape: BoxShape.rectangle,
          ),
          child: filepath != ""
              ? Image.file(File(filepath))
              : const Center(child: Icon(Icons.photo_camera))));
}

Widget netImageBox(height, width, String url) {
  return url == ""
      ? Container(
          width: height,
          height: width,
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.rectangle,
            image: null,
          ),
          child: const Center(child: Icon(Icons.photo_camera)))
      : Container(
          width: height,
          height: width,
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              )),
          child: Container());
}
