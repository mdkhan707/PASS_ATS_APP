// lib/View/Screens/pdf_preview_screen.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Uint8List pdfData;
  const PdfPreviewScreen({required this.pdfData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Resume'),
      ),
      body: SfPdfViewer.memory(
        pdfData,
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
