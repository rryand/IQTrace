import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen(this.cameras);

  final cameras;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeCameraController;


  CameraDescription _getFrontCamera(List<CameraDescription> cameras) {
    //return cameras.singleWhere(
    //  (camera) => camera.lensDirection == CameraLensDirection.front);
    return cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front
    );
  }

  Future<void> _onPressed(Map arguments) async {
    try {
      await _initializeCameraController;
      
      final image = await _controller?.takePicture();

      Navigator.pushNamed(
        context,
        '/register/camera/image',
        arguments: {'imagePath': image?.path, ...arguments}
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('ERROR: ${e.toString()}')));
    }
  }

  @override
  void initState() {
    super.initState();
    CameraDescription frontCamera = _getFrontCamera(widget.cameras);
    
    _controller = CameraController(frontCamera, ResolutionPreset.max);
    _initializeCameraController = _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _onPressed(arguments),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: _initializeCameraController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller!);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
