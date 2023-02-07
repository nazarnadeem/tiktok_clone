import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.to(
        ConfirmScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        ),
      );
    } else {
      Get.snackbar('Oops!', "No Video Selected");
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(
                    ImageSource.gallery,
                    context,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.image,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(
                    ImageSource.camera,
                    context,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera_alt,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Get.back(),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.close,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
