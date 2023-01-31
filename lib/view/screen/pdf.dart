




import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class pdf extends StatefulWidget {
  const pdf({Key? key}) : super(key: key);

  @override
  State<pdf> createState() => _pdfState();
}

class _pdfState extends State<pdf> {
  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/page.pdf'),
  );

// Simple Pdf view with one render of page (loose quality on zoom)

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(),
      body: PdfView(
        controller: pdfController,
        renderer: (PdfPage page) => page.render(
          width: page.width * 2,
          height: page.height * 2,
       //   format: PdfPageFormat.JPEG,
          backgroundColor: '#FFFFFF',
        ),
      ),
    );
  }
}
