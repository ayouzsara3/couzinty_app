import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/features/upload/data/repos/upload_repo_impl.dart';
import 'package:couzinty/features/upload/presentation/viewmodel/upload_cubit/upload_cubit.dart';
import 'package:couzinty/features/upload/presentation/views/widgets/upload_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadCubit>(
      create: (context) => UploadCubit(getIt<UploadRepoImpl>()),
      child: const SafeArea(
        child: Scaffold(
          body: UploadViewBody(),
        ),
      ),
    );
  }
}
