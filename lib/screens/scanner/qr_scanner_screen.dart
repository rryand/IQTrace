import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iq_trace/services/room_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  Map<String, dynamic>? decodedData;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          _buildFlipCameraButton(),
          _buildFlashButton(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          decodedData == null ? 
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text('Format: ${ describeEnum(result!.format) }'),
                  ...?_buildDecodedData(result?.code),
                ],
              ),
            ) :
            Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildFlipCameraButton() {
    return IconButton(
      onPressed: () async {
        await controller?.flipCamera();
      },
      icon: Icon(Icons.flip_camera_android),
    );
  }

  Widget _buildFlashButton() {
    return IconButton(
      onPressed: () async {
        var info = await controller?.getCameraInfo();
        if (info == CameraFacing.back) {
          await controller?.toggleFlash();
        }
      },
      icon: FutureBuilder(
        future: controller?.getFlashStatus(),
        builder: (context, snapshot) {
          var icon;
          icon = (snapshot.data == true) ? Icons.flash_off : Icons.flash_on;
          return Icon(icon);
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    double getScanArea() {
      var screenSize = MediaQuery.of(context).size;
      return (screenSize.width < 400 || screenSize.height < 400) ? 150.0 : 300.0;
    }

    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: getScanArea(),
      ),
    );
  }

  List<Widget>? _buildDecodedData(String? jsonData) {
    if (jsonData == null) return null;

    setState(() {
      decodedData = jsonDecode(jsonData);
    });

    final List<Widget> widgets = [];
    decodedData?.forEach((key, value) {
      widgets.add(Text(key + ': ' + value));
    });

    return widgets;
  }

  // TODO: update room record
  void _onQRViewCreated(QRViewController controller) {
    RoomService _roomService = RoomService();

    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      if (decodedData == null) return;
      controller.pauseCamera();
      _roomService.addTimelog(decodedData!).then(
        (value) => Navigator.of(context).popUntil(ModalRoute.withName('/home'))
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
