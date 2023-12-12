import "dart:io";

import "package:flutter/material.dart";

class ProfileImage extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  ProfileImage({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),
        child: image != null
            ? ClipOval(
                child: Image.file(
                  image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 40,
              ),
      ),
    );
  }
}
