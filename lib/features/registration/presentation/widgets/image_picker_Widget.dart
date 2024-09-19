import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File?) onImagePicked; // Callback for image picking

  const ImagePickerWidget({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        widget.onImagePicked(_imageFile); // Call the callback with the picked image
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      setState(() {
        _isLoading = false; // End loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.4,
            height: screenWidth * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.2),
              border: Border.all(
                color: Colors.white,
                width: 4.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.2),
              child: _isLoading
                  ? CircularProgressIndicator() // Loading indicator
                  : _imageFile != null
                  ? Image.file(
                _imageFile!,
                fit: BoxFit.cover,
              )
                  : Image.network(
                'https://randomuser.me/api/portraits/lego/5.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 15,
            child: Container(
              height: screenWidth * 0.090 * 1.05,
              width: screenWidth * 0.090 * 1.05,
              decoration: BoxDecoration(
                color: Color(0xff0078A4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  onPressed: _pickImage,
                  icon: Icon(Icons.camera_alt),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
