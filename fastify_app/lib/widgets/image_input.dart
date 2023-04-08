import 'dart:io';

import 'package:fastify_app/utils/constants.dart';
import 'package:fastify_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File) onSelectImage;
  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImage;

  Future<dynamic> _showPickerDialog() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: SizedBox(
          height: 120,
          child: Column(
            children: [
              ListTile(
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
              ListTile(
                title: const Text('Take Picture'),
                onTap: () {
                  Navigator.of(ctx).pop(false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    final bool selectedOption = await _showPickerDialog();
    final picker = ImagePicker();
    final storedImage = await picker.pickImage(
      source: selectedOption ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 100,
    );
    if (storedImage == null) {
      return;
    }
    final croppedImage = await Helpers.cropImage(File(storedImage.path));
    setState(() {
      _pickedImage = croppedImage;
    });
    widget.onSelectImage(croppedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: kPrimaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: _pickedImage != null
                ? Image.file(
                    _pickedImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/profile.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          child: InkWell(
            onTap: _takePicture,
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
