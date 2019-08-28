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
  dynamic scan;

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
        CodeFormat.ean13,
        CodeFormat.ean8,
        CodeFormat.qr,
        CodeFormat.upca,
        CodeFormat.upce
      ],
      (dynamic value) {
        setState(() {
          scan = value;

          _confirmScan();
        });
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

  _confirmScan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scan Complete'),
          content: Text("$scan"),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
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