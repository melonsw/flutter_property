import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud/utils/color_util.dart';
import 'package:flutter/material.dart';

class TakePickerPage extends StatefulWidget {
  @override
  TakePickerPageState createState() => TakePickerPageState();
}

class TakePickerPageState extends State<TakePickerPage> {
  List<CameraDescription> cameras = [];

  initCamera() async {
    cameras = await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    cameras = ModalRoute.of(context).settings.arguments;
    if (cameras == null || cameras.length < 1) {
      initCamera();
    }
    return Scaffold(
      body: (cameras.length > 0)
          ? HomeContent(camera: cameras[0])
          : Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  child: Text('Not Find Camera'))),
    );
  }
}

class HomeContent extends StatefulWidget {
  final CameraDescription camera;

  HomeContent({Key key, @required this.camera}) : super(key: key);

  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Container(
                child: CameraPreview(_cameraController),
                width: double.infinity,
                height: double.infinity,
              );
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 16, top: 45),
          child: GestureDetector(
            onTap: (){
              Navigator.maybePop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            splashColor: Colors.white60,
            highlightColor: Colors.white38,
            child: Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Text(
                '拍照',
                style: TextStyle(
                    color: ColorUtil.blue2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () async {
              try {
                await _initializeControllerFuture;
                XFile file = await _cameraController.takePicture();
                print(file.path);
                Navigator.maybePop(context, file.path);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) =>
                //       DisplayPictureScreen(imagePath: file.path),
                // ));
              } catch (err, stack) {
                print(err);
              }
            },
          ),
        ),
      ],
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拍照'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
