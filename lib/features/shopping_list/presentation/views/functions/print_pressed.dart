import 'package:couzinty/core/utils/functions/load_font.dart';
import 'package:couzinty/features/shopping_list/presentation/views/widgets/build_pdf_data.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> printPressed(List<List<dynamic>> ingredientsList) async {
  final font =
      await loadFont('assets/fonts/OpenSans-VariableFont_wdth,wght.ttf');

  final doc = pw.Document();
  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return buildPdfData(ingredientsList, font);
      }));
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}
