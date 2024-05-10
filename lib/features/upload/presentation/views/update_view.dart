import 'package:couzinty/features/upload/presentation/views/widgets/upload_view_body.dart';
import 'package:flutter/material.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: UploadViewBody(),
      ),
    );
  }
}
