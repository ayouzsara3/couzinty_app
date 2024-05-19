import 'package:couzinty/core/utils/functions/load_font.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:couzinty/features/shopping_list/presentation/views/widgets/build_pdf_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

Future<void> sharePressed(BuildContext context) async {
  final ingredients = context.read<UserCubit>().state.shoppingList!;
  final ingredientsList =
      ingredients.map((ingredient) => [ingredient, false]).toList();

  final doc = pw.Document();

  // load the supported font for pdf
  final font =
      await loadFont('assets/fonts/OpenSans-VariableFont_wdth,wght.ttf');

  // build the pdf
  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return buildPdfData(ingredientsList, font);
      }));

  final pdfBytes = await doc.save();

  // create xfile from the pdf
  final xFile = XFile.fromData(
    pdfBytes,
    mimeType: 'application/pdf',
    name: 'shopping_list.pdf',
  );

  // share the file
  Share.shareXFiles([xFile]);
}
