import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

class QrScanner extends StatefulWidget {
  QrScanner({ Key key }) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<StatefulWidget> {
  List<CameraDescription> cameras;
  QRReaderController controller;
  bool canRender;

  _QrScannerState();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    canRender = false;

    _setupWidget();
  }

  Future<void> _setupWidget() async {
    cameras = await availableCameras();

    controller = QRReaderController(
      cameras[0],
      ResolutionPreset.high,
      [
        CodeFormat.code128,
        CodeFormat.code39,
        CodeFormat.code93,
        CodeFormat.datamatrix,
        CodeFormat.ean13,
        CodeFormat.ean8,
        CodeFormat.itf,
        CodeFormat.pdf417,
        CodeFormat.qr,
        CodeFormat.upca,
        CodeFormat.upce
      ],
      (dynamic value) {
        print(value);

        Future.delayed(const Duration(seconds: 3), controller.startScanning);
      }
    );

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        canRender = true;
      });
      controller.startScanning();
    });
  }

  @override
    Widget build(BuildContext context) {
      if (!canRender) {
        return new Container();
      }
      return new AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: new QRReaderPreview(controller));
  }
}