// import 'dart:ui';
//
// import 'package:get/get.dart';
//
// import 'package:syncfusion_flutter_pdf/pdf.dart';
//
// class PDFController extends GetxController {
//   Future<void> _createPDF() async {
//     //Create a new PDF document
//     PdfDocument document = PdfDocument();
//
//     //Add a new page and draw text
//     document.pages.add().graphics.drawString(
//         'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: Rect.fromLTWH(0, 0, 500, 50));
//
//     //Save the document
//     List<int> bytes = document.save();
//
//     //Dispose the document
//     document.dispose();
//   }
// }
