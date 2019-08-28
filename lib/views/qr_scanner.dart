import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

import 'package:christmas_list/constants/theme.dart';

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

    controller?.dispose();
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
        // CodeFormat.code128,
        // CodeFormat.code39,
        // CodeFormat.code93,
        // CodeFormat.datamatrix,
        CodeFormat.ean13,
        CodeFormat.ean8,
        // CodeFormat.itf,
        // CodeFormat.pdf417,
        CodeFormat.qr,
        CodeFormat.upca,
        CodeFormat.upce
      ],
      (dynamic value) {
        print(value);
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
        return Container();
      }
      // return AspectRatio(
      //   aspectRatio: 1,
      //   child: QRReaderPreview(controller)
      // );

      return Scaffold(
        backgroundColor: AppTheme.primary[500],
        appBar: AppBar(
          title: Text('Scan A Barcode'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Container(
              //   child: Column(
              //     children: <Widget>[
              //       Text('1. Point your camera at a barcode'),
              //       Text('2. Point your camera at a barcode'),
              //       Text('3. Point your camera at a barcode'),
              //     ],
              //   )
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / controller.value.aspectRatio,
                child: Container(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: QRReaderPreview(controller),
                  ),
                )
              )
            ],
          )
        )
      );
  }
}