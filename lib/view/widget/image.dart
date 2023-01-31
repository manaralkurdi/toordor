import 'package:flutter/material.dart';
import 'package:toordor/view/widget/constant.dart';

class ImagePickerDialog extends StatefulWidget {
  final GestureTapCallback onCameraPressed;

  final GestureTapCallback onGalleryPressed;

  const ImagePickerDialog(
      {required this.onCameraPressed, required this.onGalleryPressed});

  @override
  _ImagePickerDialogState createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          //borderRadius: border,
          color: Colors.white,
        ),
        child: Wrap(
          children: <Widget>[
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Divider(
                    color: ColorCustome.colorblue,
                    thickness: 1,
                  )),
            ),
            Container(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 10.0),
                Text(
                 "chosse"
                ),
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: ColorCustome.colorblue,
                ),
              ],
            ),
            Container(height: 10.0),
            ListTile(
                leading:
                Icon(Icons.photo_library, color: ColorCustome.colorblue, size: 35.0),
                title: Text(
                 "gallery"
                ),
                onTap: () {
                  widget.onGalleryPressed();
                }),
            ListTile(
              leading:
              Icon(Icons.photo_camera, color: ColorCustome.coloryellow, size: 35.0),
              title: Text(
                "camera",
              ),
              onTap: () {
                widget.onCameraPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}
