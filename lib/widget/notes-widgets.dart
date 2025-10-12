import 'package:flutter/material.dart';

Widget box() {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      width: 350,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: TextField(
          maxLines: null,
          style: TextStyle(fontSize: 16, height: 2),
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    ),
  );
}
