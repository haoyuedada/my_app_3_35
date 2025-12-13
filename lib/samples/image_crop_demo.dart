import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

class ImageCropDemo extends StatefulWidget {
  @override
  _ImageCropDemoState createState() => _ImageCropDemoState();
}

class _ImageCropDemoState extends State<ImageCropDemo> {
  final cropKey = GlobalKey<CropState>();
  File? _imageFile;
  File? _croppedFile;

  // Note: ImagePicker is not used in this demo to avoid additional dependencies
  // Users should add image_picker dependency and implement image selection if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Crop Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _imageFile == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('请选择一张图片'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Implement image selection logic here
                          },
                          child: Text('选择图片'),
                        ),
                      ],
                    )
                  : Crop(
                      key: cropKey,
                      image: FileImage(_imageFile!),
                      aspectRatio: 1.0,
                    ),
            ),
          ),
          if (_imageFile != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _cropImage,
                    child: Text('裁剪图片'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _imageFile = null;
                        _croppedFile = null;
                      });
                    },
                    child: Text('重置'),
                  ),
                ],
              ),
            ),
          if (_croppedFile != null)
            Expanded(
              child: Center(
                child: Image.file(_croppedFile!),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_imageFile == null) return;
    
    final crop = cropKey.currentState;
    if (crop == null) return;
    
    final area = crop.area;
    if (area == null) return;
    
    try {
      final cropped = await ImageCrop.cropImage(
        file: _imageFile!,
        area: area,
      );
      setState(() {
        _croppedFile = cropped;
      });
    } catch (e) {
      print('Error cropping image: $e');
    }
  }
}