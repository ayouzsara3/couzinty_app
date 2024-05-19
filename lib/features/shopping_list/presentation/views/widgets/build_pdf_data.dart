import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

buildPdfData(List<List<dynamic>> shoppingList, pw.Font font) =>
    pw.Column(children: [
      pw.Text(
        'Liste de courses',
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 32,
          font: font,
        ),
      ),
      pw.SizedBox(height: 16),
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
        child: pw.ListView.builder(
          itemCount: shoppingList.length,
          itemBuilder: (context, index) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
                bottom: 0,
              ),
              child: pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0xff1FCC79),
                  borderRadius: pw.BorderRadius.circular(15),
                ),
                child: pw.Row(
                  children: [
                    pw.Text(
                      shoppingList[index][0],
                      style: pw.TextStyle(
                        color: const PdfColor.fromInt(0xffffffff),
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        decorationThickness: 2,
                        font: font,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    ]);
